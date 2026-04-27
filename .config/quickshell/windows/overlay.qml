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
        active: true

        Variants {
            model: Quickshell.screens

            PanelWindow {
                required property var modelData
                screen: modelData

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
                visible: root.overlayVisible
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
            }
        }
    }
}