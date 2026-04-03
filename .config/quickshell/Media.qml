import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import Quickshell.Io

Item {
    id: media
    property string mediaText: ""
    property string mediaClass: "stopped"
    property real mediaPosition: 0
    property real mediaLength: 0

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Pill {
            id: pill
            text: `${mediaText}`
            color: "white"
            position: posCenter;
            iconVisible: mediaClass === "playing" || mediaClass === "paused"
            Item {
                implicitWidth: 20
                implicitHeight: 20
                Shape {
                    anchors.fill: parent
                    layer.enabled: true
                    layer.samples: 16
                    ShapePath {
                        strokeColor: "#494949"
                        strokeWidth: 2
                        fillColor: "#494949"

                        // Start at the circle's edge
                        startX: 10; startY: 1

                        // PathAngleArc needs to know the center of the circle/arc
                        PathAngleArc {
                            centerX: 10; centerY: 10
                            radiusX: 9; radiusY: 9
                            startAngle: 0
                            sweepAngle: 360
                        }
                        PathLine { x: 10; y: 10 }
                    }
                    ShapePath {
                        strokeColor: "#ffffffff"
                        strokeWidth: 2
                        fillColor: "#494949"

                        // Start at the circle's edge
                        startX: 10; startY: 1

                        // PathAngleArc needs to know the center of the circle/arc
                        PathAngleArc {
                            centerX: 10; centerY: 10
                            radiusX: 9; radiusY: 9
                            startAngle: -90
                            sweepAngle: (mediaLength > 0) ? Math.min(360, Math.max(0, (mediaPosition / mediaLength * 360))) : 0
                        }
                    }
                }
                MaterialSymbol {
                    anchors.centerIn: parent
                    fill: 1
                    text: (mediaClass === "playing") ? "music_note" : "pause"
                    color: "white"
                }
            }
        }
        TapHandler {
            acceptedButtons: Qt.MiddleButton | Qt.BackButton | Qt.ForwardButton
            onTapped: (eventPoint, button) => {
                if (button === Qt.MiddleButton) {
                    playPauseProc.exec(["playerctl", "play-pause"])
                } else if (button === Qt.BackButton) {
                    playPauseProc.exec(["playerctl", "previous"])
                } else if (button === Qt.ForwardButton) {
                    playPauseProc.exec(["playerctl", "next"])
                }
            }
        }
        Process {
            id: playPauseProc
        }
    }

    Process {
        id: mediaProc
        command: ["playerctl", "--player=%any", "metadata", "--format", "{{lc(status)}}|{{artist}} - {{title}}|{{position}}|{{mpris:length}}", "--follow"]
        running: true
        stderr: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                if (data.includes("No players found")) {
                    media.mediaClass = "stopped"
                    media.mediaText = ""
                    media.mediaPosition = 0
                    media.mediaLength = 0
                }
            }
        }
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const parts = data.trim().split("|");
                if (parts.length >= 4) {
                    media.mediaClass = parts[0]
                    let text = parts[1]
                    if (text === " - ") {
                        media.mediaText = ""
                    } else {
                        if (text.startsWith(" - ")) text = text.substring(3)
                        if (text.endsWith(" - ")) text = text.substring(0, text.length - 3)
                        media.mediaText = text.length > 100 ? text.substring(0, 97) + "..." : text
                    }
                    const pos = (parseInt(parts[2]) / 1000000) || 0
                    const len = (parseInt(parts[3]) / 1000000) || 0
                    media.mediaPosition = Math.min(pos, len)
                    media.mediaLength = len
                }
            }
        }
    }
}