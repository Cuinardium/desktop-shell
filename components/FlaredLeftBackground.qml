pragma ComponentBehavior: Bound
import QtQuick
import qs.style

Canvas {
    id: background
    anchors.fill: parent

    // --- CONFIGURATION ---
    // The inner concave cut-out radius (the "melt" effect)
    property real flareRadius: Tokens.appearance.rounding.normal 
    // The outer convex corners on the right side
    property real cornerRadius: Tokens.appearance.rounding.normal 
    property color effectColor: Theme.surface // Or Theme.background depending on your contrast needs
    // ---------------------

    // Only redraw the canvas when the physical geometry or color actually changes
    onWidthChanged: requestPaint()
    onHeightChanged: requestPaint()
    onEffectColorChanged: requestPaint()

    onPaint: {
        var ctx = getContext("2d");
        ctx.reset();
        ctx.fillStyle = effectColor;
        ctx.globalAlpha = 1;

        var w = width;
        var h = height;
        var f = flareRadius;
        var r = cornerRadius;

        ctx.beginPath();

        // 1. Top-Left Tip (Flush against the absolute top-left pixel of the bounding box)
        ctx.moveTo(0, 0);

        // 2. Top Concave Flare
        // The control point (0, f) pulls the curve straight down along the screen edge, 
        // smoothly arching to become perfectly horizontal at (f, f)
        ctx.quadraticCurveTo(0, f, f, f);

        // 3. Top Edge & Top-Right Convex Corner
        ctx.lineTo(w - r, f);
        ctx.arcTo(w, f, w, f + r, r);

        // 4. Right Edge & Bottom-Right Convex Corner
        ctx.lineTo(w, h - f - r);
        ctx.arcTo(w, h - f, w - r, h - f, r);

        // 5. Bottom Edge & Bottom Concave Flare
        ctx.lineTo(f, h - f);
        // The control point (0, h - f) pulls the curve perfectly horizontal,
        // smoothly arching to point straight down to the absolute bottom-left pixel (0, h)
        ctx.quadraticCurveTo(0, h - f, 0, h);

        // 6. Left Edge
        // Close the path by drawing a straight line up the monitor edge
        ctx.lineTo(0, 0);

        ctx.closePath();
        ctx.fill();
    }
}
