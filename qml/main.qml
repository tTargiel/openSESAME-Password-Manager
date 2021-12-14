import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Window {
    id: mainWindow
    title: qsTr("openSESAME")
    height: Screen.height * 0.75
    width: Screen.width * 0.65
    x: (Screen.width - this.width) / 2
    y: (Screen.height - this.height) / 2
    
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window
    onAfterRendering: {
        loginWindow.hide()
    }
    visible: true

    property bool maxmin: true
    property int clickCount: 0
    readonly property double changedX: mainBackground.width * 0.65 - floatingLogo.width / 2
    readonly property double changedY: mainBackground.height * 0.45 - floatingLogo.height / 2

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
        y: menuPadding
        
        onPaint: {
            var radius = 16;
            var ctx = mainBackground.getContext("2d");
            ctx.beginPath();
            ctx.moveTo(this.width - radius, 0);
            ctx.arcTo(this.width, 0, this.width, 0, 0);
            ctx.lineTo(this.width, this.height - menuPadding - radius);
            ctx.arcTo(this.width, this.height - menuPadding, this.width - radius, this.height - menuPadding, radius);
            ctx.lineTo(radius, this.height - menuPadding);
            ctx.arcTo(0, this.height - menuPadding, 0, this.height - menuPadding - radius, radius);
            ctx.lineTo(0, 0);
            ctx.arcTo(0, 0, radius, 0, 0);
            var gradient = ctx.createLinearGradient(this.width * 0.4, 0, this.width - this.width * 0.4, this.height);
            gradient.addColorStop(0.3, "#0a2472");
            gradient.addColorStop(0.7, "#001c55");
            gradient.addColorStop(1.0, "#00072d");
            ctx.fillStyle = gradient;
            ctx.fill();
        }

        Image {
            id: floatingLogo
            height: 384
            width: 384
            x: changedX
            y: changedY

            fillMode: Image.PreserveAspectFit

            source: "qrc:/images/logo/openSESAME.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (clickCount % 2 === 0) {
                        animateMovementX.stop()
                        animateMovementY.stop()
                    }
                    else {
                        animateMovementX.start()
                        animateMovementY.start()
                    }
                    clickCount++
                }
            }

            SequentialAnimation {
                id: animateMovementX

                loops: Animation.Infinite
                running: true
                NumberAnimation {target: floatingLogo; property: "x"; to: (changedX + 72); duration: 1500}
                NumberAnimation {target: floatingLogo; property: "x"; to: (changedX - 96); duration: 1750}
                NumberAnimation {target: floatingLogo; property: "x"; to: (changedX); duration: 1500}
            }

            SequentialAnimation {
                id: animateMovementY

                loops: Animation.Infinite
                running: true
                NumberAnimation {target: floatingLogo; property: "y"; to: (changedY + 48); duration: 1500}
                NumberAnimation {target: floatingLogo; property: "y"; to: (changedY + 128); duration: 1750}
                NumberAnimation {target: floatingLogo; property: "y"; to: (changedY); duration: 2000}
            }
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

    WindowControls {
        property Canvas componentBackground: mainBackground
        property Window componentWindow: mainWindow
        property bool maximizeOption: true
    }
}
