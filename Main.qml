import QtQuick 2.0
import QtQuick.Controls

Window {
    id: id_rootWin
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello snapshot.")

    property int counter: 1

    Column {
        spacing: 10
        Rectangle {
            id: sourceRectangle
            width: 100
            height: 100

            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "red"
                }
                GradientStop {
                    position: 0.33
                    color: "yellow"
                }
                GradientStop {
                    position: 1.0
                    color: "green"
                }
            }
            Text {
                id: id_text
                text: id_rootWin.counter
            }
        }
        Image {
            id: image
            width: 200
            height: 200
        }

        // Define a Button to trigger the snapshot
        Button {
            x: id_rootWin.width / 3
            text: "Snapshot"
            onClicked: {
                var grabRet = sourceRectangle.grabToImage(
                            function (itemGrabResult) {
                                image.source = itemGrabResult.url
                                itemGrabResult.saveToFile("/tmp/something.png")
                            }, Qt.size(sourceRectangle.width,
                                       sourceRectangle.height))
                if (false === grabRet) {
                    console.log("grab screen failed...")
                    return
                }
                id_rootWin.counter = id_rootWin.counter + 1
            }
        }

        Component.onCompleted: {
            console.log("loaded...")
        }
    }
}
