import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Quickshell
import Quickshell.Services.Pipewire
import "." as Windows

FloatingWindow {
    id: root
    signal requestClose

    visible: true
    title: "Quickshell Overlay"
    implicitWidth: 420
    implicitHeight: 260
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: "#111111"
        border.color: "#40ffffff"
        radius: 8

        ScrollView {
            anchors {
                fill: parent
                topMargin: 36
            }
            contentWidth: availableWidth

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                Label {
                    text: "Outputs"
                    color: "#f2f2f2"
                    font.pixelSize: 13
                    font.weight: Font.DemiBold
                }

                Rectangle {
                    Layout.fillWidth: true
                    color: "#33ffffff"
                    implicitHeight: 1
                }

                Repeater {
                    model: Pipewire.nodes

                    delegate: Windows.MixerEntry {
                        required property PwNode modelData
                        Layout.fillWidth: true
                        visible: modelData.audio !== null && modelData.isSink
                        node: modelData
                    }
                }

            }
        }
    }

    Windows.OverlayTitleBar {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
    }

    Shortcut {
        sequence: "Escape"
        onActivated: root.requestClose()
    }
}
