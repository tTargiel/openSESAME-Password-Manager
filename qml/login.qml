import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Window {
    id: loginWindow
    title: qsTr("openSESAME - Login")
    height: Screen.height * 0.6
    width: Screen.width * 0.25
    x: (Screen.width - this.width) / 2
    y: (Screen.height - this.height) / 2
    
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window
    visible: true

    Loader {
        id: main
        visible: false
        source: visible ? "qrc:/qml/main.qml" : ""
    }

    Connections {
        target: _authenticate
        function onVisibilityChanged(vis) { main.visible = vis }
        function onLoginState(loginMessage) { loginFeedback.text = loginMessage }
    }

    property int deltaNavigation: 48
    property int menuPadding: 32
    property int whenClickedX
    property int whenClickedY

    Canvas {
        id: loginBackground
        height: loginWindow.height
        width: loginWindow.width
        x: 0
        y: menuPadding
        
        onPaint: {
            var radius = 16;
            var ctx = loginBackground.getContext("2d");
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

        SwipeView {
            id: loginPages

            anchors.fill: parent
            currentIndex: 0
            interactive: false

            Item {
                id: loginPageOne

                ColumnLayout {
                    x: deltaNavigation
                    y: 0

                    spacing: 20

                    Rectangle {
                        id: welcome
                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredHeight: 192

                        Text {
                            id: welcomeMessage
                            x: 0
                            y: 96
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "white"
                            font.family: "Helvetica"
                            font.pointSize: 16
                            text: qsTr("Welcome to <b>openSESAME</b>")
                        }

                        Text {
                            id: loginPrompt
                            x: 0
                            y: 128
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "white"
                            font.family: "Helvetica"
                            font.pointSize: 16
                            text: qsTr("Please log in down below:")
                        }
                    }

                    TextField {
                        id: dbUsername
                        Layout.preferredWidth: 384
                        Layout.preferredHeight: 48
                        placeholderText: qsTr("Username")
                        font.family: "Helvetica"
                        font.pointSize: 14
                        background: Rectangle {
                            radius: 8
                            implicitWidth: 100
                            implicitHeight: 32
                            border.color: "#333"
                            border.width: 1
                        }

                        onActiveFocusChanged: loginFeedback.text = qsTr("")
                    }

                    TextField {
                        id: dbPassword
                        Layout.preferredWidth: 384
                        Layout.preferredHeight: 48
                        placeholderText: qsTr("Password")
                        font.family: "Helvetica"
                        font.pointSize: 14
                        echoMode: TextInput.Password
                        background: Rectangle {
                            radius: 8
                            implicitWidth: 100
                            implicitHeight: 32
                            border.color: "#333"
                            border.width: 1
                        }

                        onActiveFocusChanged: loginFeedback.text = qsTr("")
                    }

                    Rectangle {
                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredHeight: 32

                        Text {
                            id: loginFeedback
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "white"
                            font.family: "Helvetica"
                            font.pointSize: 12
                            text: qsTr("")
                        }
                    }

                    Button {
                        id: loginVault
                        text: qsTr("Log in")

                        enabled: true
                        font.bold: true
                        font.family: "Helvetica"
                        font.pointSize: 14
                        Layout.alignment: Qt.AlignCenter

                        background: Rectangle {
                            color: "#0a2472"
                            implicitHeight: 40
                            implicitWidth: 256
                            opacity: enabled ? 1 : 0.5
                            radius: 16
                        }

                        contentItem: Text {
                            color: parent.down ? "#1a1a1a" : "#ffffff"
                            font: parent.font
                            horizontalAlignment: Text.AlignHCenter
                            opacity: enabled ? 1 : 0.5
                            text: parent.text
                            verticalAlignment: Text.AlignVCenter
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                dbUsername.focus = false
                                dbPassword.focus = false
                                _authenticate.buttonClicked(dbUsername.text, dbPassword.text)
                            }
                        }
                    }

                    Button {
                        id: registerVault
                        text: qsTr("Register")

                        enabled: true
                        font.bold: true
                        font.family: "Helvetica"
                        font.pointSize: 14
                        Layout.alignment: Qt.AlignCenter

                        background: Rectangle {
                            color: "#0a2472"
                            implicitHeight: 40
                            implicitWidth: 256
                            opacity: enabled ? 1 : 0.5
                            radius: 16
                        }

                        contentItem: Text {
                            color: parent.down ? "#1a1a1a" : "#ffffff"
                            font: parent.font
                            horizontalAlignment: Text.AlignHCenter
                            opacity: enabled ? 1 : 0.5
                            text: parent.text
                            verticalAlignment: Text.AlignVCenter
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                dbUsername.text = qsTr("")
                                dbPassword.text = qsTr("")
                                loginPages.currentIndex = 1
                            }
                        }
                    }

                    /*Button {
                        text: "Global Context Property Counter: " + _myGlobalObject.counter
                        Layout.alignment: Qt.AlignCenter
//                        visible: false

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (_myGlobalObject.counter === 0) {
                                    _myGlobalObject.doSomething("TEXT FROM QML")
                                    _myGlobalObject.counter += 1
                                }
                                else {
                                    _myGlobalObject.counter += 1
                                }
                            }
                        }
                    }*/
                }
            }

            Item {
                id: loginPageTwo

                ColumnLayout {
                    x: deltaNavigation
                    y: 0

                    spacing: 20

                    Rectangle {
                        id: welcomeVault
                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredHeight: 128

                        Text {
                            id: welcomeVaultPrompt
                            x: 0
                            y: 64
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "white"
                            font.family: "Helvetica"
                            font.pointSize: 16
                            text: qsTr("Please register down below:")
                        }
                    }

                    TextField {
                        id: dbVUsername
                        Layout.preferredWidth: 384
                        Layout.preferredHeight: 48
                        placeholderText: qsTr("Username")
                        font.family: "Helvetica"
                        font.pointSize: 14
                        background: Rectangle {
                            radius: 8
                            implicitWidth: 100
                            implicitHeight: 32
                            border.color: "#333"
                            border.width: 1
                        }

                        onActiveFocusChanged: createVaultFeedback.text = qsTr("")
                    }

                    TextField {
                        id: dbVPassword
                        Layout.preferredWidth: 384
                        Layout.preferredHeight: 48
                        placeholderText: qsTr("Password")
                        font.family: "Helvetica"
                        font.pointSize: 14
                        echoMode: TextInput.Password
                        background: Rectangle {
                            radius: 8
                            implicitWidth: 100
                            implicitHeight: 32
                            border.color: "#333"
                            border.width: 1
                        }

                        onActiveFocusChanged: createVaultFeedback.text = qsTr("")
                    }

                    TextField {
                        id: dbVPassword2
                        Layout.preferredWidth: 384
                        Layout.preferredHeight: 48
                        placeholderText: qsTr("Confirm password")
                        font.family: "Helvetica"
                        font.pointSize: 14
                        echoMode: TextInput.Password
                        background: Rectangle {
                            radius: 8
                            implicitWidth: 100
                            implicitHeight: 32
                            border.color: "#333"
                            border.width: 1
                        }

                        onActiveFocusChanged: createVaultFeedback.text = qsTr("")
                    }

                    Rectangle {
                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredHeight: 32

                        Text {
                            id: createVaultFeedback
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "white"
                            font.family: "Helvetica"
                            font.pointSize: 12
                            text: qsTr("")
                        }
                    }

                    Button {
                        id: createVault
                        text: qsTr("Create new vault")

                        enabled: true
                        font.bold: true
                        font.family: "Helvetica"
                        font.pointSize: 14
                        Layout.alignment: Qt.AlignCenter

                        background: Rectangle {
                            color: "#0a2472"
                            implicitHeight: 40
                            implicitWidth: 256
                            opacity: enabled ? 1 : 0.5
                            radius: 16
                        }

                        contentItem: Text {
                            id: createVaultText
                            color: parent.down ? "#1a1a1a" : "#ffffff"
                            font: parent.font
                            horizontalAlignment: Text.AlignHCenter
                            opacity: enabled ? 1 : 0.5
                            text: parent.text
                            verticalAlignment: Text.AlignVCenter
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                dbVUsername.focus = false
                                dbVPassword.focus = false
                                dbVPassword2.focus = false
                                //                                register.buttonClicked(dbVUsername.text, dbVPassword.text, dbVPassword2.text)
                            }
                        }
                    }

                    Button {
                        id: goBack
                        text: qsTr("< Back")

                        enabled: true
                        font.bold: true
                        font.family: "Helvetica"
                        font.pointSize: 14
                        Layout.alignment: Qt.AlignCenter

                        background: Rectangle {
                            color: "#0a2472"
                            implicitHeight: 40
                            implicitWidth: 256
                            opacity: enabled ? 1 : 0.5
                            radius: 16
                        }

                        contentItem: Text {
                            color: parent.down ? "#1a1a1a" : "#ffffff"
                            font: parent.font
                            horizontalAlignment: Text.AlignHCenter
                            opacity: enabled ? 1 : 0.5
                            text: parent.text
                            verticalAlignment: Text.AlignVCenter
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                dbVUsername.text = qsTr("")
                                dbVPassword.text = qsTr("")
                                dbVPassword2.text = qsTr("")
                                loginPages.currentIndex = 0
                            }
                        }
                    }
                }
            }
        }
    }

    WindowControls {
        property Canvas componentBackground: loginBackground
        property Window componentWindow: loginWindow
        property bool maximizeOption: false
    }
}
