import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12

Window {
    id: mainWindow
    title: qsTr("openSESAME")
    height: Screen.height * 0.75
    width: Screen.width * 0.65
    x: (Screen.width - this.width) / 2
    y: (Screen.height - this.height) / 2
    
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window
    visible: true

    property bool maxmin: true
    property int deltaNavigation: 48
    property int menuPadding: 32
    property int whenClickedX
    property int whenClickedY

    Canvas {
        id: mainBackground
        height: mainWindow.height
        width: {
            if (mainWindow.width === Screen.width) {
                mainWindow.width
            }
            else {
                mainWindow.width - deltaNavigation
            }
        }
        x: {
            if (mainWindow.width === Screen.width) {
                0
            }
            else {
                deltaNavigation
            }
        }
        y: 0
        
        onPaint: {
            var radius = 16;
            var ctx = mainBackground.getContext("2d");
            ctx.beginPath();
            ctx.moveTo(this.width - radius, menuPadding);
            ctx.arcTo(this.width, menuPadding, this.width, menuPadding, 0);
            ctx.lineTo(this.width, this.height - radius);
            ctx.arcTo(this.width, this.height, this.width - radius, this.height, radius);
            ctx.lineTo(radius, this.height);
            ctx.arcTo(0, this.height, 0, this.height - radius, radius);
            ctx.lineTo(0, menuPadding);
            ctx.arcTo(0, menuPadding, radius, menuPadding, 0);
            var gradient = ctx.createLinearGradient(this.width * 0.4, 0, this.width - this.width * 0.4, this.height);
            gradient.addColorStop(0.3, "#0a2472");
            gradient.addColorStop(0.7, "#001c55");
            gradient.addColorStop(1.0, "#00072d");
            ctx.fillStyle = gradient;
            ctx.fill();
        }
    }

    Canvas {
        id: mainNavigation
        height: mainWindow.height * 0.85
        width: this.height * 0.543
        x: {
            if (mainWindow.width === Screen.width) {
                deltaNavigation
            }
            else {
                0
            }
        }
        y: (mainBackground.height + menuPadding - this.height) / 2
        
        onPaint: {
            var radius = 16;
            var ctx = mainNavigation.getContext("2d");
            ctx.beginPath();
            ctx.moveTo(this.width - radius, 0);
            ctx.arcTo(this.width, 0, this.width, radius, radius);
            ctx.lineTo(this.width, this.height - radius);
            ctx.arcTo(this.width, this.height, this.width - radius, this.height, radius);
            ctx.lineTo(radius, this.height);
            ctx.arcTo(0, this.height, 0, this.height - radius, radius);
            ctx.lineTo(0, radius);
            ctx.arcTo(0, 0, radius, 0, radius);
            var gradient = ctx.createLinearGradient(this.width, 0, 0, this.height);
            gradient.addColorStop(0.2, "#004e89");
            gradient.addColorStop(0.8, "#407ba7");
            ctx.fillStyle = gradient;
            ctx.fill();
        }
        
        ColumnLayout {
            x: deltaNavigation
            y: mainNavigation.height * 0.1

            spacing: 20

            RoundButton {
                text: "\u2713"
                
                font.pointSize: 40
                Layout.alignment: Qt.AlignCenter
                Layout.preferredHeight: 120
                Layout.preferredWidth: 120
                onClicked: {
                    linwinControls.visible = false
                    macOSControls.visible = true
                }
            }

            Rectangle {
                Layout.preferredHeight: 40
            }

            Button {
                id: vault
                text: qsTr("Vault")
                
                enabled: true
                font.bold: true
                font.family: "Helvetica"
                font.pointSize: 14

                background: Rectangle {
                    /*border.color: parent.down ? "#1a1a1a" : "#ffffff"
                    border.width: 1*/
                    color: "#0a2472"
                    implicitHeight: 40
                    implicitWidth: mainNavigation.width * 0.8
                    opacity: enabled ? 1 : 0.5
                    radius: 16
                }
                
                contentItem: Text {
                    color: parent.down ? "#1a1a1a" : "#ffffff"
                    elide: Text.ElideRight
                    font: parent.font
                    horizontalAlignment: Text.AlignHCenter
                    opacity: enabled ? 1 : 0.5
                    text: parent.text
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Button {
                id: passwordGenerator
                text: qsTr("Password Generator")
                
                enabled: true
                font.bold: true
                font.family: "Helvetica"
                font.pointSize: 14

                background: Rectangle {
                    /*border.color: parent.down ? "#1a1a1a" : "#ffffff"
                    border.width: 1*/
                    color: "#0a2472"
                    implicitHeight: 40
                    implicitWidth: mainNavigation.width * 0.8
                    opacity: enabled ? 1 : 0.5
                    radius: 16
                }
                
                contentItem: Text {
                    color: parent.down ? "#1a1a1a" : "#ffffff"
                    elide: Text.ElideRight
                    font: parent.font
                    horizontalAlignment: Text.AlignHCenter
                    opacity: enabled ? 1 : 0.5
                    text: parent.text
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Button {
                id: appSettings
                text: qsTr("App Settings")
                
                enabled: true
                font.bold: true
                font.family: "Helvetica"
                font.pointSize: 14

                background: Rectangle {
                    /*border.color: parent.down ? "#1a1a1a" : "#ffffff"
                    border.width: 1*/
                    color: "#0a2472"
                    implicitHeight: 40
                    implicitWidth: mainNavigation.width * 0.8
                    opacity: enabled ? 1 : 0.5
                    radius: 16
                }
                
                contentItem: Text {
                    color: parent.down ? "#1a1a1a" : "#ffffff"
                    elide: Text.ElideRight
                    font: parent.font
                    horizontalAlignment: Text.AlignHCenter
                    opacity: enabled ? 1 : 0.5
                    text: parent.text
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle {
                Layout.preferredHeight: 80
            }

            Button {
                id: lockLogOut
                text: qsTr("Lock and Log Out")
                
                enabled: true
                font.bold: true
                font.family: "Helvetica"
                font.pointSize: 14

                background: Rectangle {
                    /*border.color: parent.down ? "#1a1a1a" : "#ffffff"
                    border.width: 1*/
                    color: "#0a2472"
                    implicitHeight: 40
                    implicitWidth: mainNavigation.width * 0.8
                    opacity: enabled ? 1 : 0.5
                    radius: 16
                }
                
                contentItem: Text {
                    color: parent.down ? "#1a1a1a" : "#ffffff"
                    elide: Text.ElideRight
                    font: parent.font
                    horizontalAlignment: Text.AlignHCenter
                    opacity: enabled ? 1 : 0.5
                    text: parent.text
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: mainWindow.close()
                }
            }
        }
    }

    Rectangle {
        id: windowControls
        height: 48
        width: mainBackground.width
        x: mainBackground.x
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

            anchors {
                top: parent.top
            }

            onMouseXChanged: {
                var dx = mouseX - whenClickedX
                mainWindow.setX(mainWindow.x + dx)
            }

            onMouseYChanged: {
                var dy = mouseY - whenClickedY
                mainWindow.setY(mainWindow.y + dy)
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

                source: "qrc:/images/icons/linwin/minimizeNormal.png"

                HoverHandler {
                    onHoveredChanged: hovered ? linwinMinimize.source = "qrc:/images/icons/linwin/minimize.png" : linwinMinimize.source = "qrc:/images/icons/linwin/minimizeNormal.png"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: mainWindow.showMinimized()
                }
            }

            Image {
                id: linwinMaximize
                x: 51
                y: 0

                source: "qrc:/images/icons/linwin/maximizeNormal.png"

                HoverHandler {
                    onHoveredChanged: hovered ? linwinMaximize.source = "qrc:/images/icons/linwin/maximize.png" : linwinMaximize.source = "qrc:/images/icons/linwin/maximizeNormal.png"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (maxmin === true) {
                            mainWindow.showMaximized()
                            maxmin = false
                        }
                        else {
                            mainWindow.showNormal()
                            maxmin = true
                        }
                    }
                }
            }

            Image {
                id: linwinClose
                x: 102
                y: 0
                
                source: "qrc:/images/icons/linwin/closeNormal.png"

                HoverHandler {
                    onHoveredChanged: hovered ? linwinClose.source = "qrc:/images/icons/linwin/close.png" : linwinClose.source = "qrc:/images/icons/linwin/closeNormal.png"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mainWindow.close()
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

                source: "qrc:/images/icons/macOS/close.png"

                HoverHandler {
                    onHoveredChanged: hovered ? macOSClose.opacity = 0.8 : macOSClose.opacity = 1
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mainWindow.close()
                    }
                }
            }

            Image {
                id: macOSMinimize
                x: 28
                y: 4

                source: "qrc:/images/icons/macOS/minimize.png"

                HoverHandler {
                    onHoveredChanged: hovered ? macOSMinimize.opacity = 0.8 : macOSMinimize.opacity = 1
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: mainWindow.showMinimized()
                }
            }

            Image {
                id: macOSMaximize
                x: 52
                y: 4

                source: "qrc:/images/icons/macOS/maximize.png"

                HoverHandler {
                    onHoveredChanged: hovered ? macOSMaximize.opacity = 0.8 : macOSMaximize.opacity = 1
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (maxmin === true) {
                            mainWindow.showMaximized()
                            maxmin = false
                        }
                        else {
                            mainWindow.showNormal()
                            maxmin = true
                        }
                    }
                }
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: mainWindow.title
            topPadding: parent.radius / 2
        }
    }
}
