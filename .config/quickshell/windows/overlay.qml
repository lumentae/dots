pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Window
import Quickshell
import Quickshell.Io
import QtQuick.Layouts
import Quickshell.Widgets

Scope {
    id: root

    signal requestClose
    property bool overlayVisible: false

    LazyLoader {
        active: root.overlayVisible

        PanelWindow {
            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            exclusiveZone: 0

            implicitWidth: screen?.width ?? 1
            implicitHeight: screen?.height ?? 1
            color: "transparent"
            visible: true
            focusable: true

            Rectangle {
                anchors.fill: parent
                color: "#40000000"

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.requestClose()
                }
            }

            Keys.onEscapePressed: root.requestClose()
            Rectangle {
                id: floatingWindow
                width: 420
                height: 260
                radius: 12
                color: "#1e1e2e"
                border.color: "#45475a"
                z: 10
                x: (parent.width - width) / 2
                y: (parent.height - height) / 2
                MouseArea {
                    anchors.fill: parent
                    onClicked: function(mouse) {
                        mouse.accepted = true
                    }
                }

                // draggable title bar
                Rectangle {
                    id: titleBar
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    height: 36
                    color: "#313244"
                    radius: parent.radius
                    MouseArea {
                        anchors.fill: parent
                        drag.target: floatingWindow
                        drag.minimumX: 0
                        drag.minimumY: 0
                        drag.maximumX: floatingWindow.parent.width - floatingWindow.width
                        drag.maximumY: floatingWindow.parent.height - floatingWindow.height
                        cursorShape: Qt.SizeAllCursor
                    }
                }
            }
        }
    }
}