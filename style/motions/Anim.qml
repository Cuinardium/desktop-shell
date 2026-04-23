import QtQuick
import qs.style

PropertyAnimation {
    enum Type {
        StandardSmall = 0,
        Standard,
        StandardLarge,
        StandardExtraLarge,
        EmphasizedSmall,
        Emphasized,
        EmphasizedLarge,
        EmphasizedExtraLarge,
        FastSpatial,
        DefaultSpatial,
        SlowSpatial
    }

    property int type: Anim.Standard

    duration: {
        if (type < Tokens.appearance.curves.StandardSmall || type > Anim.SlowSpatial)
            return Tokens.appearance.animDurations.normal;

        if (type == Tokens.appearance.curves.FastSpatial)
            return Tokens.appearance.animDurations.expressiveFastSpatial;
        if (type == Tokens.appearance.curves.DefaultSpatial)
            return Tokens.appearance.animDurations.expressiveDefaultSpatial;
        if (type == Tokens.appearance.curves.SlowSpatial)
            return Tokens.appearance.animDurations.expressiveSlowSpatial;

        const types = ["small", "normal", "large", "extraLarge"];
        const idx = type % 4; // 0-7 are the 4 standard types
        return Tokens.appearance.animDurations[types[idx]];
    }
    easing.type: Easing.Bezier
    easing.bezierCurve: {
        if (type == Tokens.appearance.curves.FastSpatial)
            return Tokens.appearance.curves.expressiveFastSpatial;
        if (type == Tokens.appearance.curves.DefaultSpatial)
            return Tokens.appearance.curves.expressiveDefaultSpatial;
        if (type == Tokens.appearance.curves.SlowSpatial)
            return Tokens.appearance.curves.expressiveSlowSpatial;

        if (type >= Tokens.appearance.curves.EmphasizedSmall && type <= Anim.EmphasizedExtraLarge)
            return Tokens.appearance.curves.emphasized;
        return Tokens.appearance.curves.standard;
    }
}
