import QtQuick

Rectangle {
    id: windowControls
    height: 48
    width: componentBackground.width
    x: componentBackground.x
    y: 0
    z: -1

    anchors.top: parent.top
    color: "#000814"
    radius: 16

    MouseArea {
        height: deltaNavigation
        width: parent.width
        x: 0
        y: 0

        anchors.fill: parent

        onMouseXChanged: {
            var dx = mouseX - whenClickedX
            componentWindow.setX(componentWindow.x + dx)
        }

        onMouseYChanged: {
            var dy = mouseY - whenClickedY
            componentWindow.setY(componentWindow.y + dy)
        }

        onPressed: {
            whenClickedX = mouseX
            whenClickedY = mouseY
        }
    }

    Rectangle {
        id: linwinControls
        height: 32
        width: 153

        anchors {
            right: parent.right
            top: parent.top
        }
        color: "transparent"
        visible: {
            if (Qt.platform.os !== "osx") {
                true
            }
            else {
                false
            }
        }

        Image {
            id: linwinMinimize
            x: 0
            y: 0

            source: "qrc:/images/windowControls/linwin/minimizeNormal.png"

            HoverHandler {
                onHoveredChanged: hovered ? linwinMinimize.source = "qrc:/images/windowControls/linwin/minimize.png" : linwinMinimize.source = "qrc:/images/windowControls/linwin/minimizeNormal.png"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: componentWindow.showMinimized()
            }
        }

        Image {
            id: linwinMaximize
            x: 51
            y: 0

            source: "qrc:/images/windowControls/linwin/maximizeNormal.png"

            HoverHandler {
                onHoveredChanged: (maximizeOption ? hovered : null) ? linwinMaximize.source = "qrc:/images/windowControls/linwin/maximize.png" : linwinMaximize.source = "qrc:/images/windowControls/linwin/maximizeNormal.png"
            }

            MouseArea {
                anchors.fill: maximizeOption ? parent : null
                onClicked: {
                    if (maxmin === true) {
                        componentWindow.showMaximized()
                        maxmin = false
                    }
                    else {
                        componentWindow.showNormal()
                        maxmin = true
                    }
                }
            }
        }

        Image {
            id: linwinClose
            x: 102
            y: 0

            source: "qrc:/images/windowControls/linwin/closeNormal.png"

            HoverHandler {
                onHoveredChanged: hovered ? linwinClose.source = "qrc:/images/windowControls/linwin/close.png" : linwinClose.source = "qrc:/images/windowControls/linwin/closeNormal.png"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    componentWindow.close()
                }
            }
        }
    }

    Rectangle {
        id: macOSControls
        height: 32
        width: 76

        anchors {
            left: parent.left
            top: parent.top
        }
        color: "transparent"
        visible: {
            if (Qt.platform.os === "osx") {
                true
            }
            else {
                false
            }
        }

        Image {
            id: macOSClose
            x: 4
            y: 4

            source: "qrc:/images/windowControls/macOS/close.png"

            HoverHandler {
                onHoveredChanged: hovered ? macOSClose.opacity = 0.8 : macOSClose.opacity = 1
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    componentWindow.close()
                }
            }
        }

        Image {
            id: macOSMinimize
            x: 28
            y: 4

            source: "qrc:/images/windowControls/macOS/minimize.png"

            HoverHandler {
                onHoveredChanged: hovered ? macOSMinimize.opacity = 0.8 : macOSMinimize.opacity = 1
            }

            MouseArea {
                anchors.fill: parent
                onClicked: componentWindow.showMinimized()
            }
        }

        Image {
            id: macOSMaximize
            x: 52
            y: 4

            source: maximizeOption ? "qrc:/images/windowControls/macOS/maximize.png" : "qrc:/images/windowControls/macOS/disabled.png"

            HoverHandler {
                onHoveredChanged: (maximizeOption ? hovered : null) ? macOSMaximize.opacity = 0.8 : macOSMaximize.opacity = 1
            }

            MouseArea {
                anchors.fill: maximizeOption ? parent : null
                onClicked: {
                    if (maxmin === true) {
                        componentWindow.showMaximized()
                        maxmin = false
                    }
                    else {
                        componentWindow.showNormal()
                        maxmin = true
                    }
                }
            }
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        color: "white"
        text: componentWindow.title
        topPadding: parent.radius / 2
    }
}
