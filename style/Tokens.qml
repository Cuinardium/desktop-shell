pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell

Singleton {
    id: root

    // --- Appearance Tokens ---
    property QtObject appearance: QtObject {
        property QtObject curves: QtObject {
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

        property QtObject rounding: QtObject {
            readonly property int extraSmall: 5
            readonly property int small: 12
            readonly property int normal: 17
            readonly property int large: 25
            readonly property int full: 1000
        }

        property QtObject spacing: QtObject {
            readonly property int smaller: 8
            readonly property int small: 12
            readonly property int normal: 16
            readonly property int large: 20
            readonly property int larger: 24
        }

        property QtObject padding: QtObject {
            readonly property int smaller: 5
            readonly property int small: 7
            readonly property int normal: 10
            readonly property int large: 12
            readonly property int larger: 15
        }

        property QtObject fontSize: QtObject {
            readonly property int smaller: 11
            readonly property int small: 12
            readonly property int normal: 13
            readonly property int large: 15
            readonly property int larger: 18
            readonly property int extraLarge: 28
        }

        property QtObject fontFamily: QtObject {
            readonly property string sans: "Geist"
            readonly property string material: "Material Symbols Outlined"
        }

        property QtObject animDurations: QtObject {
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
    }

    // --- Size Tokens ---
    property QtObject sizes: QtObject {
        property QtObject bar: QtObject {
            readonly property int innerWidth: 40
            readonly property int windowPreviewSize: 400
            readonly property int trayMenuWidth: 300
            readonly property int batteryWidth: 250
            readonly property int networkWidth: 320
            readonly property int kbLayoutWidth: 320
        }

        property QtObject dashboard: QtObject {
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

        property QtObject launcher: QtObject {
            readonly property int itemWidth: 600
            readonly property int itemHeight: 57
            readonly property int wallpaperWidth: 280
            readonly property int wallpaperHeight: 200
        }

        property QtObject notifs: QtObject {
            readonly property int width: 400
            readonly property int image: 41
            readonly property int badge: 20
        }

        property QtObject osd: QtObject {
            readonly property int sliderWidth: 30
            readonly property int sliderHeight: 150
        }

        property QtObject session: QtObject {
            readonly property int button: 80
        }

        property QtObject sidebar: QtObject {
            readonly property int width: 430
        }

        property QtObject utilities: QtObject {
            readonly property int width: 430
            readonly property int toastWidth: 430
        }

        property QtObject lock: QtObject {
            readonly property real heightMult: 0.7
            readonly property real ratio: 16.0 / 9.0
            readonly property int centerWidth: 600
        }

        property QtObject winfo: QtObject {
            readonly property real heightMult: 0.7
            readonly property real detailsWidth: 500
        }

        property QtObject controlCenter: QtObject {
            readonly property real heightMult: 0.7
            readonly property real ratio: 16.0 / 9.0
        }
    }
}
