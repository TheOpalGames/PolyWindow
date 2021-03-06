package net.theopalgames.polywindow.libgdx.html;

import com.google.gwt.core.client.JavaScriptObject;
import net.theopalgames.polywindow.*;
import net.theopalgames.polywindow.transformation.Transformation;

import java.util.List;

final class HtmlStubWindow extends Window {
    public HtmlStubWindow(WindowManager windowManager, String name, int x, int y, int z, boolean vsync, boolean showMouse, JavaScriptObject ctx) {
        super(windowManager, name, x, y, z, vsync, showMouse, null, null);
    }
    
    @Override
    protected void run() {
    
    }
    
    @Override
    public void setShowCursor(boolean show) {
    
    }
    
    @Override
    public void setIcon(String icon) {
    
    }
    
    @Override
    public void fillOval(double x, double y, double sX, double sY) {
    
    }
    
    @Override
    public void fillOval(double x, double y, double z, double sX, double sY, boolean depthTest) {
    
    }
    
    @Override
    public void fillFacingOval(double x, double y, double z, double sX, double sY, boolean depthTest) {
    
    }
    
    @Override
    public void fillGlow(double x, double y, double sX, double sY) {
    
    }
    
    @Override
    public void fillGlow(double x, double y, double z, double sX, double sY, boolean depthTest) {
    
    }
    
    @Override
    public void fillFacingGlow(double x, double y, double z, double sX, double sY, boolean depthTest) {
    
    }
    
    @Override
    public void setColor(double r, double g, double b, double a) {
    
    }
    
    @Override
    public void setColor(double r, double g, double b) {
    
    }
    
    @Override
    public void drawOval(double x, double y, double sX, double sY) {
    
    }
    
    @Override
    public void drawOval(double x, double y, double z, double sX, double sY) {
    
    }
    
    @Override
    public void fillRect(double x, double y, double sX, double sY) {
    
    }
    
    @Override
    public void fillBox(double x, double y, double z, double sX, double sY, double sZ) {
    
    }
    
    @Override
    public void fillBox(double x, double y, double z, double sX, double sY, double sZ, byte options) {
    
    }
    
    @Override
    public void fillQuad(double x1, double y1, double x2, double y2, double x3, double y3, double x4, double y4) {
    
    }
    
    @Override
    public void fillQuadBox(double x1, double y1, double x2, double y2, double x3, double y3, double x4, double y4, double z, double sZ, byte options) {
    
    }
    
    @Override
    public void drawRect(double x, double y, double sX, double sY) {
    
    }
    
    @Override
    public void drawImage(double x, double y, double sX, double sY, String image, boolean scaled) {
    
    }
    
    @Override
    public void drawImage(double x, double y, double z, double sX, double sY, String image, boolean scaled) {
    
    }
    
    @Override
    public void drawImage(double x, double y, double sX, double sY, double u1, double v1, double u2, double v2, String image, boolean scaled) {
    
    }
    
    @Override
    public void drawImage(double x, double y, double z, double sX, double sY, double u1, double v1, double u2, double v2, String image, boolean scaled) {
    
    }
    
    @Override
    public void drawImage(double x, double y, double z, double sX, double sY, double u1, double v1, double u2, double v2, String image, boolean scaled, boolean depthtest) {
    
    }
    
    @Override
    public void drawImage(double x, double y, double sX, double sY, String image, double rotation, boolean scaled) {
    
    }
    
    @Override
    public void drawImage(double x, double y, double z, double sX, double sY, String image, double rotation, boolean scaled) {
    
    }
    
    @Override
    public void drawImage(double x, double y, double sX, double sY, double u1, double v1, double u2, double v2, String image, double rotation, boolean scaled) {
    
    }
    
    @Override
    public void drawImage(double x, double y, double z, double sX, double sY, double u1, double v1, double u2, double v2, String image, double rotation, boolean scaled) {
    
    }
    
    @Override
    public void drawImage(double x, double y, double z, double sX, double sY, double u1, double v1, double u2, double v2, String image, double rotation, boolean scaled, boolean depthtest) {
    
    }
    
    @Override
    public String getClipboard() {
        return null;
    }
    
    @Override
    public void setClipboard(String s) {
    
    }
    
    @Override
    public void setVsync(boolean enable) {
    
    }
    
    @Override
    public List<Integer> getRawTextKeys() {
        return null;
    }
    
    @Override
    public String getKeyText(int key) {
        return null;
    }
    
    @Override
    public String getTextKeyText(int key) {
        return null;
    }
    
    @Override
    public int translateKey(int key) {
        return 0;
    }
    
    @Override
    public int translateTextKey(int key) {
        return 0;
    }
    
    @Override
    public double getEdgeBounds() {
        return 0;
    }
    
    @Override
    public void setBatchMode(boolean enabled, boolean quads, boolean depth) {
    
    }
    
    @Override
    public void setBatchMode(boolean enabled, boolean quads, boolean depth, boolean glow) {
    
    }
    
    @Override
    public void addVertex(double x, double y, double z) {
    
    }
    
    @Override
    public void addVertex(double x, double y) {
    
    }
    
    @Override
    public List<Transformation> getTransformations() {
        return null;
    }
    
    @Override
    public Framework getFramework() {
        return null;
    }
    
    @Override
    public void quit() {
    
    }
    
    @Override
    public boolean canQuit() {
        return false;
    }
    
    @Override
    protected Window newWindow(String name, int x, int y, int z, boolean vsync, boolean showMouse, IUpdater updater, IDrawer drawer) {
        return null;
    }
    
//    @Override
//    protected Window newWindow(String name, int x, int y, int z, boolean vsync, boolean showMouse) {
//        return null;
//    }
    
    @Override
    protected boolean canMakeNewWindow() {
        return false;
    }
}
