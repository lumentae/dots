import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire

ColumnLayout {
    id: root
    required property PwNode node
    readonly property var audio: root.node?.audio ?? null

    // Keep this node bound so all properties stay reactive.
    PwObjectTracker {
        objects: [root.node]
    }

    RowLayout {
        spacing: 8

        Image {
            visible: source !== ""
            source: {
                const icon = root.node.properties["application.icon-name"] ?? "audio-volume-high-symbolic";
                return `image://icon/${icon}`;
            }
            sourceSize.width: 20
            sourceSize.height: 20
        }

        Label {
            Layout.fillWidth: true
            elide: Text.ElideRight
            color: "#f0f0f0"
            text: {
                // application.name -> description -> node name
                const app = root.node.properties["application.name"] ?? (root.node.description !== "" ? root.node.description : root.node.name);
                const media = root.node.properties["media.name"];
                return media !== undefined ? `${app} - ${media}` : app;
            }
        }

        Button {
            enabled: root.audio !== null
            text: (root.audio?.muted ?? false) ? "unmute" : "mute"
            onClicked: if (root.audio !== null) root.audio.muted = !root.audio.muted
        }
    }

    RowLayout {
        spacing: 8

        Label {
            Layout.preferredWidth: 50
            color: "#cfcfcf"
            text: `${Math.floor((root.audio?.volume ?? 0) * 100)}%`
        }

        Slider {
            Layout.fillWidth: true
            enabled: root.audio !== null
            value: root.audio?.volume ?? 0
            onMoved: if (root.audio !== null) root.audio.volume = value
        }
    }
}