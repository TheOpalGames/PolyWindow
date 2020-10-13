#include "main-objc.h"

#ifndef AAPLTextureIndexBaseColor
#define AAPLTextureIndexBaseColor 0
#endif

@import simd;

typedef struct {
    matrix_float4x4 matrix;
} Transformation;

@implementation PolyWindowContext

-(id)init:(void *)cppCtx {
    self = [super init];
    
    [self retain]; // mem addr stored in Java.
    self.cppCtx = cppCtx;
    
    return self;
}

-(void) postInit {
    [self.viewController setContext:self];
    
    self.device = MTLCreateSystemDefaultDevice();
    self.library = [self.device newDefaultLibrary];
    self.commands = [self.device newCommandQueue];
    
    self.metalLayer = [CAMetalLayer layer];
    self.metalLayer.device = self.device;
    self.metalLayer.pixelFormat = MTLPixelFormatBGRA8Unorm;
    self.metalLayer.frame = [[self.viewController view] frame];
    [[self.viewController view].layer addSublayer:self.metalLayer];
    
    self.uniformBuffer = [self.device newBufferWithLength:sizeof(Transformation) options:MTLResourceOptionCPUCacheModeDefault];
    self.hasTransformations = false;
    
    self.showCursor = true;
    self.vsync = true;
    
    MTLRenderPipelineDescriptor *desc = [[MTLRenderPipelineDescriptor alloc] init];
    [desc setVertexFunction:[self.library newFunctionWithName:@"vertex_main"]];
    [desc setFragmentFunction:[self.library newFunctionWithName:@"fragment_main"]];
    desc.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    self.pipelineState = [self.device newRenderPipelineStateWithDescriptor:desc error:nil];
    
}

@end

//void init() {
//    currentCtx = [[NSMutableDictionary alloc] init];
//}

//static void unused(char a, ...) {
//    // NOOP, just to get rid of compiler warnings.
//}

void createApp(void *cppCtx) {
    PolyWindowContext *ctx = [[PolyWindowContext alloc] init:cppCtx];
    [[NSThread currentThread] threadDictionary][INIT_KEY] = ctx;
    
    const char *argv[0];
    NSApplicationMain(0, argv);
}

void draw(PolyWindowContext *ctx, int primitive, int nVertices, float vertexData[]) {
    id<MTLBuffer> vertexBuffer = [ctx.device newBufferWithBytes:vertexData length:nVertices options:MTLResourceOptionCPUCacheModeDefault];
    
    [ctx.renderEncoder setRenderPipelineState:ctx.pipelineState];
    [ctx.renderEncoder setVertexBuffer:vertexBuffer offset:0 atIndex:1];
    [ctx.renderEncoder drawPrimitives:primitive vertexStart:0 vertexCount:nVertices];
}

static matrix_float4x4 toMatrix(double *matrix) {
    matrix_float4x4 res = {
        .columns[0] = {matrix[ 0], matrix[ 1], matrix[ 2], matrix[ 3]},
        .columns[1] = {matrix[ 4], matrix[ 5], matrix[ 6], matrix[ 7]},
        .columns[2] = {matrix[ 8], matrix[ 9], matrix[10], matrix[11]},
        .columns[3] = {matrix[12], matrix[13], matrix[14], matrix[15]}
    };
    return res;
}

static matrix_float4x4 multiplyMatrices(int nMatrices, double **matrices) {
    matrix_float4x4 finalMatrix = toMatrix(matrices[nMatrices-2]);
    
    for (int i = nMatrices-2; i >= 0; i++) {
        finalMatrix = simd_mul(toMatrix(matrices[i]), finalMatrix);
    }
    
    return finalMatrix;
}

void replaceMatrices(PolyWindowContext *ctx, int nMatrices, double **matrices) {
    if (nMatrices == 0) {
        ctx.hasTransformations = false;
        return;
    }
    
    matrix_float4x4 theMatrix = multiplyMatrices(nMatrices, matrices);
    
    Transformation transformation;
    transformation.matrix = theMatrix;
    memcpy([ctx.uniformBuffer contents], &transformation, sizeof(Transformation));
    
    ctx.hasTransformations = true;
}

void toggleShowCursor(PolyWindowContext *ctx) {
    if (ctx.showCursor)
        [NSCursor hide];
    else
        [NSCursor unhide];
    
    ctx.showCursor = !(ctx.showCursor);
}

void toggleVsync(PolyWindowContext *ctx) {
    [ctx.viewController disableTimers];
    
    if (ctx.vsync)
        [ctx.viewController enableVsync];
    else
        [ctx.viewController enableConstantRefresh];
    
    ctx.vsync = !(ctx.vsync);
}

Texture *loadTexture(PolyWindowContext *ctx, char *bytes, int width, int height) {
    MTLTextureDescriptor *desc = [[MTLTextureDescriptor alloc] init];
    desc.pixelFormat = MTLPixelFormatBGRA8Unorm;
    desc.width = width;
    desc.height = height;
    
    id<MTLTexture> texture = [ctx.device newTextureWithDescriptor:desc];
    
    Texture *textureData = malloc(sizeof(Texture));
    textureData->texture = texture;
    textureData->width = width;
    textureData->height = height;
    textureData->bytes = bytes;
    
    [textureData->texture retain]; // held by Java
    
    return textureData;
}

void setTexture(PolyWindowContext *ctx, Texture *texture, float originX, float originY, float sizeX, float sizeY) {
    if (texture != NULL) {
        MTLRegion region = {
            {originX, originY, 0},
            {texture->width, texture->height, 1}
        };
        
        [texture->texture replaceRegion:region mipmapLevel:0 withBytes:texture->bytes bytesPerRow:(4*texture->width)];
    }
    
    [ctx.renderEncoder setFragmentTexture:texture->texture atIndex:AAPLTextureIndexBaseColor];
}

char *getClipboard() {
    NSPasteboard *clipboard = [NSPasteboard generalPasteboard];
    NSData *data = [clipboard dataForType:NSPasteboardTypeString];
    return (char *) [data bytes];
}

void setClipboard(char *text) {
    NSPasteboard *clipboard = [NSPasteboard generalPasteboard];
    NSString *nsText = [[NSString alloc] initWithUTF8String:text];
    [clipboard setString:nsText forType:NSPasteboardTypeString];
}

PolyWindowContext *newWindow(PolyWindowContext *ctx, void *cppCtx) {
    ViewController *viewController = [[ViewController alloc] init];
    PolyWindowContext *newCtx = [[PolyWindowContext alloc] init:cppCtx];
    [viewController setContext:newCtx];
    
    [NSWindow windowWithContentViewController:viewController];
    [newCtx postInit];
    
    return newCtx;
}
