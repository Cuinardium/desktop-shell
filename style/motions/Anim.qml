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
        if (type < Anim.StandardSmall || type > Anim.SlowSpatial)
            return Tokens.appearance.animDurations.normal;

        if (type === Anim.FastSpatial)
            return Tokens.appearance.animDurations.expressiveFastSpatial;
        if (type === Anim.DefaultSpatial)
            return Tokens.appearance.animDurations.expressiveDefaultSpatial;
        if (type === Anim.SlowSpatial)
            return Tokens.appearance.animDurations.expressiveSlowSpatial;

        const types = ["small", "normal", "large", "extraLarge"];
        const idx = type % 4;
        return Tokens.appearance.animDurations[types[idx]];
    }
    easing.type: Easing.Bezier
    easing.bezierCurve: {
        if (type === Anim.FastSpatial)
            return Tokens.appearance.curves.expressiveFastSpatial;
        if (type === Anim.DefaultSpatial)
            return Tokens.appearance.curves.expressiveDefaultSpatial;
        if (type === Anim.SlowSpatial)
            return Tokens.appearance.curves.expressiveSlowSpatial;

        if (type >= Anim.EmphasizedSmall && type <= Anim.EmphasizedExtraLarge)
            return Tokens.appearance.curves.emphasized;
        return Tokens.appearance.curves.standard;
    }
}
