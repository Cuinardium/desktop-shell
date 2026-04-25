pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell

Singleton {
    id: root

    // =========================================================================
    // APPEARANCE TYPES
    // =========================================================================

    component CurveTokens: QtObject {
        readonly property var emphasized: [0.05, 0, 2.0 / 15.0, 0.06, 1.0 / 6.0, 0.4, 5.0 / 24.0, 0.82, 0.25, 1, 1, 1]
        readonly property var emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
        readonly property var emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
        readonly property var standard: [0.2, 0, 0, 1, 1, 1]
        readonly property var standardAccel: [0.3, 0, 1, 1, 1, 1]
        readonly property var standardDecel: [0, 0, 0, 1, 1, 1]
        readonly property var expressiveFastSpatial: [0.42, 1.67, 0.21, 0.9, 1, 1]
        readonly property var expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1, 1, 1]
        readonly property var expressiveSlowSpatial: [0.39, 1.29, 0.35, 0.98, 1, 1]
        readonly property var expressiveFastEffects: [0.31, 0.94, 0.34, 1, 1, 1]
        readonly property var expressiveDefaultEffects: [0.34, 0.8, 0.34, 1, 1, 1]
        readonly property var expressiveSlowEffects: [0.34, 0.88, 0.34, 1, 1, 1]
    }

    component RoundingTokens: QtObject {
        readonly property int extraSmall: 5
        readonly property int small: 12
        readonly property int normal: 17
        readonly property int large: 25
        readonly property int full: 1000
    }

    component SpacingTokens: QtObject {
        readonly property int smaller: 8
        readonly property int small: 12
        readonly property int normal: 16
        readonly property int large: 20
        readonly property int larger: 24
    }

    component PaddingTokens: QtObject {
        readonly property int smaller: 5
        readonly property int small: 7
        readonly property int normal: 10
        readonly property int large: 12
        readonly property int larger: 15
    }

    component FontSizeTokens: QtObject {
        readonly property int smaller: 11
        readonly property int small: 12
        readonly property int normal: 13
        readonly property int large: 15
        readonly property int larger: 18
        readonly property int extraLarge: 28
    }

    component FontFamilyTokens: QtObject {
        readonly property string sans: "Geist"
        readonly property string material: "Material Symbols Outlined"
    }

    component AnimDurationTokens: QtObject {
        readonly property int small: 200
        readonly property int normal: 400
        readonly property int large: 600
        readonly property int extraLarge: 1000
        readonly property int expressiveFastSpatial: 350
        readonly property int expressiveDefaultSpatial: 500
        readonly property int expressiveSlowSpatial: 650
        readonly property int expressiveFastEffects: 150
        readonly property int expressiveDefaultEffects: 200
        readonly property int expressiveSlowEffects: 300
    }

    component AppearanceGroup: QtObject {
        property CurveTokens curves: CurveTokens {}
        property RoundingTokens rounding: RoundingTokens {}
        property SpacingTokens spacing: SpacingTokens {}
        property PaddingTokens padding: PaddingTokens {}
        property FontSizeTokens fontSize: FontSizeTokens {}
        property FontFamilyTokens fontFamily: FontFamilyTokens {}
        property AnimDurationTokens animDurations: AnimDurationTokens {}
    }

    // =========================================================================
    // SIZE TYPES
    // =========================================================================

    component BarSizes: QtObject {
        readonly property int innerWidth: 40
        readonly property int windowPreviewSize: 400
        readonly property int trayMenuWidth: 300
        readonly property int batteryWidth: 250
        readonly property int networkWidth: 320
        readonly property int kbLayoutWidth: 320
    }

    component DashboardSizes: QtObject {
        readonly property int tabIndicatorHeight: 3
        readonly property int tabIndicatorSpacing: 5
        readonly property int infoWidth: 200
        readonly property int infoIconSize: 25
        readonly property int dateTimeWidth: 110
        readonly property int mediaWidth: 200
        readonly property int mediaProgressSweep: 180
        readonly property int mediaProgressThickness: 8
        readonly property int resourceProgressThickness: 10
        readonly property int weatherWidth: 250
        readonly property int mediaCoverArtSize: 150
        readonly property int mediaVisualiserSize: 80
        readonly property int resourceSize: 200
    }

    component LauncherSizes: QtObject {
        readonly property int itemWidth: 600
        readonly property int itemHeight: 57
        readonly property int wallpaperWidth: 280
        readonly property int wallpaperHeight: 200
    }

    component NotifSizes: QtObject {
        readonly property int width: 400
        readonly property int image: 41
        readonly property int badge: 20
    }

    component OsdSizes: QtObject {
        readonly property int sliderWidth: 30
        readonly property int sliderHeight: 150
    }

    component SessionSizes: QtObject {
        readonly property int button: 80
    }

    component SidebarSizes: QtObject {
        readonly property int width: 430
    }

    component UtilitySizes: QtObject {
        readonly property int width: 430
        readonly property int toastWidth: 430
    }

    component LockSizes: QtObject {
        readonly property real heightMult: 0.7
        readonly property real ratio: 16.0 / 9.0
        readonly property int centerWidth: 600
    }

    component WinfoSizes: QtObject {
        readonly property real heightMult: 0.7
        readonly property real detailsWidth: 500
    }

    component ControlCenterSizes: QtObject {
        readonly property real heightMult: 0.7
        readonly property real ratio: 16.0 / 9.0
    }

    component SizeGroup: QtObject {
        property BarSizes bar: BarSizes {}
        property DashboardSizes dashboard: DashboardSizes {}
        property LauncherSizes launcher: LauncherSizes {}
        property NotifSizes notifs: NotifSizes {}
        property OsdSizes osd: OsdSizes {}
        property SessionSizes session: SessionSizes {}
        property SidebarSizes sidebar: SidebarSizes {}
        property UtilitySizes utilities: UtilitySizes {}
        property LockSizes lock: LockSizes {}
        property WinfoSizes winfo: WinfoSizes {}
        property ControlCenterSizes controlCenter: ControlCenterSizes {}
    }

    // =========================================================================
    // PUBLIC API (Properties actually used by other files)
    // =========================================================================

    readonly property AppearanceGroup appearance: AppearanceGroup {}
    readonly property SizeGroup sizes: SizeGroup {}
}
