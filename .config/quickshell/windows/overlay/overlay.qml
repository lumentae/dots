pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import "." as Windows

Scope {
    id: root

    signal requestClose
    property bool overlayVisible: false

    LazyLoader {
        active: root.overlayVisible

        Scope {
            id: overlayWindows
            property bool dialogReady: false

            Timer {
                id: dialogDelay
                interval: 75
                repeat: false
                running: true
                onTriggered: overlayWindows.dialogReady = true
            }

            Windows.OverlayBackdrop {
                onRequestClose: root.requestClose()
            }

            Windows.OverlayDialog {
                visible: overlayWindows.dialogReady
                onRequestClose: root.requestClose()
            }
        }
    }
}