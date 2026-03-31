// Bar.qml
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
    id: root

    Variants {
        model: Quickshell.screens;

        PanelWindow {
            required property var modelData;
            screen: modelData;

            anchors {
                top: true;
                left: true;
                right: true;
            }

            implicitHeight: 30;
            color: "transparent";

            Volume {}

            HyprlandWorkspaces {}

            Media {}

            Pill {
                text: Clock.time;
                color: "white";
                position: posRight;
            }
        }
    }
}