// HyprlandWorkspaces.qml
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Widgets

Item {
    id: root
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow?.window?.screen)
    readonly property int effectiveActiveWorkspaceId: monitor?.activeWorkspace?.id ?? 1
    property int horizontalPadding: 8
    property int verticalPadding: 3
    property int workspaceGroup: Math.ceil(effectiveActiveWorkspaceId / 10) - 1

    implicitWidth: workspaceRow.implicitWidth + (horizontalPadding * 2)
    implicitHeight: workspaceRow.implicitHeight + (verticalPadding * 2)
    width: implicitWidth
    height: implicitHeight

    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    anchors.leftMargin: 4

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: "#00000000"
        z: 0
        WheelHandler {
            onWheel: (event) => {
                if (event.angleDelta.y < 0)
                    Hyprland.dispatch(`hl.dsp.focus({ workspace = "r+1" })`)
                else if (event.angleDelta.y > 0)
                    Hyprland.dispatch(`hl.dsp.focus({ workspace = "r-1" })`)
            }
            acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        }
    }

    Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 4
        z: 1

        Repeater {
            model: 10
            Button {
                id: workspaceButton
                property var realIndex: (model.index + 1 + 10 * root.workspaceGroup)
                property bool isSelected: (root.effectiveActiveWorkspaceId === realIndex)
                width: isSelected ? (Resources.barHeight + 4) : (Resources.barHeight - 8)
                height: Resources.barHeight - 8
                background: Rectangle {
                    color: workspaceButton.isSelected ? "#ffffff" : "#77000000"
                    radius: width / 4
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                            easing.type: Easing.OutCubic
                        }
                    }
                }
                Text {
                    anchors.centerIn: parent
                    text: workspaceButton.realIndex
                    color: workspaceButton.isSelected ? "#000000" : "#ffffff"
                    Behavior on color {
                        ColorAnimation {
                            duration: 180
                            easing.type: Easing.OutCubic
                        }
                    }
                }
                onClicked: Hyprland.dispatch(`workspace ${workspaceButton.realIndex}`)
                Behavior on width {
                    NumberAnimation {
                        duration: 500
                        easing.type: Easing.OutBack
                        easing.overshoot: 1.4
                    }
                }
            }
        }
    }
}
