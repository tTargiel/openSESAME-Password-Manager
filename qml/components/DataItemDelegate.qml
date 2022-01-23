import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts
import App 1.0

Row {
    // Typed "modelData" property.
    // It is possible to use bi-directional binding with this property
    // since it is declared as a pointer to instance.
    //    property var modelData: {
    //        "url": "https://blabla/",
    //        "user": "username",
    //        "password": "user-defined-password",
    //        "doubleId": function() { console.log("id doubled") }
    //    }

    property var d

    height: implicitHeight
    spacing: 4

    Rectangle {
        color: "#aaffffff"
        height: txt.implicitHeight
        width: rightSide.width - 12
        radius: 12

        RowLayout {
            id: layout
            anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
            width: parent.width * 0.8

            Item {
                x: 0
                Text {
                    padding: 8
                    id: txt
                    text: modelData.url
                    font.pixelSize: 24

                    //                    Component.onCompleted: console.log("Welcome", model.index)
                    //                    Component.onDestruction: console.log("Bye", model.index)
                }
            }

            Item {
                x: parent.width * 0.5
                Text {
                    padding: 8
                    id: txt2
                    text: modelData.user
                    font.pixelSize: 24
                }
            }

            Item {
                x: parent.width * 0.8
                Text {
                    padding: 8
                    id: txt3
                    text: modelData.password
                    font.pixelSize: 24
                }
            }
        }

        Item {
            anchors { right: parent.right; top: parent.top; bottom: parent.bottom }
            width: 48
            height: 48

            Button {
                text: "X"
                width: 28
                height: 28
                x: (parent.width - this.width) / 2
                y: (parent.height - this.height) / 2
                z: 1

                MouseArea {
                    anchors.fill: parent
                    onClicked: provider.removeId(index)
                }
            }
        }
    }
}
