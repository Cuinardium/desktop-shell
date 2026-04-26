import QtQuick

import qs.style

Canvas {
    id: background
    anchors.fill: parent
    // Ensure margins are 0 so we can touch the absolute screen corners
    anchors.leftMargin: 0
    anchors.rightMargin: 0

    Connections {
        target: Theme
        function onBackgroundChanged() { background.requestPaint() }
    }

    onPaint: {
        var ctx = getContext("2d");
        ctx.reset();
        ctx.fillStyle = Theme.background;
        ctx.globalAlpha = 1;

        var w = width;
        var h = height;

        // --- CONFIGURATION ---
        var sideMargin = 10;    // Gap between screen edge and main bar body
        var r = Tokens.appearance.rounding.normal;            // The height/tightness of the "S" curve
        var topVertical = 5;   // <--- This is the "fill" you wanted at the top
        var bottomR = Tokens.appearance.rounding.extraSmall;       // Standard rounded corner for the bottom
        // ---------------------

        ctx.beginPath();

        // 1. TOP EDGE
        ctx.moveTo(0, 0);
        ctx.lineTo(w, 0);

        // 2. RIGHT SIDE: The "S" Transition
        ctx.lineTo(w, topVertical); // Vertical step
        // This curves from (w, topVertical) to (w - sideMargin, topVertical + r)
        // using the corner (w - sideMargin, topVertical) as the guide.
        ctx.quadraticCurveTo(w - sideMargin, topVertical, w - sideMargin, topVertical + r);

        // 3. RIGHT SIDE: Main wall and bottom corner
        ctx.lineTo(w - sideMargin, h - bottomR);
        ctx.arcTo(w - sideMargin, h, w - sideMargin - bottomR, h, bottomR);

        // 4. BOTTOM EDGE
        ctx.lineTo(sideMargin + bottomR, h);
        ctx.arcTo(sideMargin, h, sideMargin, h - bottomR, bottomR);

        // 5. LEFT SIDE: The "S" Transition
        ctx.lineTo(sideMargin, topVertical + r);
        // Curve back out to the screen edge
        ctx.quadraticCurveTo(sideMargin, topVertical, 0, topVertical);

        // 6. FINISH
        ctx.lineTo(0, 0); // Back to start

        ctx.closePath();
        ctx.fill();
    }
}
