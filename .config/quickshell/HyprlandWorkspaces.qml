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
        color: "#77000000"
        z: 0
        WheelHandler {
            onWheel: (event) => {
                if (event.angleDelta.y < 0)
                    Hyprland.dispatch(`workspace r+1`);
                else if (event.angleDelta.y > 0)
                    Hyprland.dispatch(`workspace r-1`);
            }
            acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        }
    }

    Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 8
        z: 1

        Repeater {
            model: 10
            Button {
                width: Resources.barHeight - 10
                height: Resources.barHeight - 10
                background: Rectangle {
                    radius: width / 2
                    color: effectiveActiveWorkspaceId !== model.index + 1 + 10 * workspaceGroup ? "#77000000" : "#ffffff"
                }
                Text {
                    anchors.centerIn: parent
                    text: model.index + 1 + 10 * workspaceGroup
                    color: effectiveActiveWorkspaceId !== model.index + 1 + 10 * workspaceGroup ? "#ffffff" : "#000000"
                }
                onClicked: Hyprland.dispatch(`workspace ${model.index + 1 + 10 * workspaceGroup}`)
            }
        }
    }
}
