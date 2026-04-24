import QtQuick
import QtQuick.Controls
import QtQuick.Window
import Quickshell
import Quickshell.Io
import QtQuick.Layouts
import Quickshell.Widgets

Scope {
    id: root

    property bool shouldShowOsd: false

    LazyLoader {
        active: true

        PanelWindow {
            // Since the panel's screen is unset, it will be picked by the compositor
            // when the window is created. Most compositors pick the current active monitor.

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }
            
            exclusiveZone: 0

            implicitWidth: 400
            implicitHeight: 50
            color: "transparent"

            // An empty click mask prevents the window from blocking mouse events.
            mask: Region {}

            Rectangle {
                anchors.fill: parent
                color: "#40000000"
            }
        }
    }
}