//@ pragma IconTheme breeze-dark
// shell.qml
import QtQuick
import Quickshell
import Quickshell.Io

Scope {
    id: root
    property bool overlayVisible: false

    function setOverlayVisible(visible) {
        overlayVisible = visible;
        if (overlayLoader.item)
            overlayLoader.item.overlayVisible = visible;
    }

    Bar {}

    Loader {
        id: overlayLoader
        active: true
        source: "windows/overlay/overlay.qml"

        onLoaded: root.setOverlayVisible(root.overlayVisible)
    }

    Connections {
        target: overlayLoader.item
        function onRequestClose() {
            root.setOverlayVisible(false);
        }
    }

    IpcHandler {
        target: "overlay"

        function show() {
            root.setOverlayVisible(true);
        }

        function hide() {
            root.setOverlayVisible(false);
        }

        function toggle() {
            root.setOverlayVisible(!root.overlayVisible);
        }
    }
}