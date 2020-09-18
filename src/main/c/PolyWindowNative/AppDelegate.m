#import "AppDelegate.h"
#import "main-objc.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property PolyWindowContext *ctx;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.ctx = (PolyWindowContext *) [[NSThread currentThread] threadDictionary][INIT_KEY];
    [[NSThread currentThread] threadDictionary][INIT_KEY] = nil;
    
    self.ctx.appDelegate = self;
    [self.ctx postInit];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end