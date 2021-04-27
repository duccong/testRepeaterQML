import QtQuick 2.12
import QtGraphicalEffects 1.12
import QtQuick.Layouts 1.2

Item {
    CSize {

    }

    property int displayHeight: 1080
    property double ratio: 0.4
    id: tile
    objectName: "fgMedia"
    width: (displayHeight === 1080?540:524) * ratio; height: (displayHeight)*ratio

    /*============   PROPERTY   /*============*/
    property string tileName: "Media"

    property string title: "title"

    property int progressValue: 50

    property string subTitle1: "subTitle1"
    property string subTitle2: "subTitle2"
    property string subTitle3: "subTitle3"

    property string specialText1: "specialText1"

    // Button
    property int buttonWidth : 120 * ratio
    property int buttonHeight : 120 * ratio
    // Left buttton
    property string sourceButton1: "1" // Left buttton
    property bool   isButton1Enable: true
    property int    isButton1State: 1

    // Center buttton
    property string sourceButton2: "2" // Center buttton
    property bool   isButton2Enable: true
    property int    isButton2State: 1   // [PLAY, PAUSE, MUTE, UN_MUTE,...]

    // Right buttton
    property string sourceButton3: "3" // Right buttton
    property bool   isButton3Enable: true
    property int    isButton3State: 1   // [FARVORITE, UPNEXT,...]
    /* =========== TILE NAME =========== */
    Text {
        anchors.top: parent.top
        CSize{
            content: tile.tileName
        }
        width: tile.width
        height: 90
    }

    /* =========== TITLE =========== */
    Text {
        id: title
        anchors.bottom: progressBar.top
        anchors.bottomMargin: 30*ratio
        text: tile.title
        width: tile.width
        height: 120 * ratio
        horizontalAlignment: Text.AlignHCenter
    }

    /* =========== PROGRESSBAR =========== */
    Rectangle {
        id: progressBar
        width: tile.width
        height: 60 * ratio
        anchors.top: tile.top
        anchors.topMargin: tile.height*0.45
        CSize{
            content: "progressbar: " + tile.progressValue
        }
    }

    /* =========== BOTTOM TEXT =========== */
    Text {
        id: subTitle1
        anchors.top: progressBar.top
        anchors.topMargin: 75 * ratio
        text: tile.subTitle1
        width: tile.width
        height: 120 * ratio
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: subTitle2
        anchors.top: subTitle1.top
        anchors.topMargin: 15
        text: tile.subTitle2
        width: tile.width
        height: 120 * ratio
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: subTitle3
        anchors.top: subTitle2.top
        anchors.topMargin: 15
        text: tile.subTitle3
        width: tile.width
        height: 120 * ratio
        horizontalAlignment: Text.AlignHCenter
    }

    /* =========== SPECIAL TEXT =========== */
    Text {
        id: specialText1
        anchors.bottom: gridButton.top
        text: tile.specialText1
        width: tile.width
        height: 60 * ratio
        horizontalAlignment: Text.AlignHCenter
    }
    /* =========== BUTTON BOTTOM =========== */
    GridLayout {
        CSize {
            content: ""
        }

        id: gridButton
        anchors.bottom: tile.bottom
        anchors.bottomMargin: 90 * ratio

        height: tile.buttonHeight * 1.5
        width: tile.width
        columns: button3.visible ? 3 : 2
        columnSpacing: 0
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: button1
            visible: sourceButton1 !== undefined && sourceButton1 !== ""
            width: gridButton.width / gridButton.columns
            height: gridButton.height
            CSize {
                content: ""
            }

            MouseArea {
                anchors.centerIn: button1
                CSize {
                    content: sourceButton1
                }
                id: lButtonMouseArea
                width: buttonWidth
                height: buttonHeight
                focus: true
                enabled: tile.isButton1Enable
                onPressed: {
                    tile.lPressed = true
                    tile.update()
                }
                onReleased: {
                    tile.lPressed = false
                    tile.update()
                }
                onClicked: {
                    parent.buttonClick("lbutton", "", "")
                    tile.lPressed = false
                    tile.update()
                }
            }

        }

        Rectangle {
            id: button2
            visible: sourceButton2 !== undefined && sourceButton2 !== ""

            width: gridButton.width / gridButton.columns
            height: gridButton.height
            CSize {
                content: ""
            }
            MouseArea {
                anchors.centerIn: button2
                CSize {
                    content: sourceButton2
                }
                id: cButtonMouseArea
                width: buttonWidth
                height: buttonHeight
                focus: true
                enabled: tile.isButton2Enable
                //            onMouseTouched: {
                //                tile.cPressed = true
                //                tile.update()
                //            }
                onReleased: {
                    tile.cPressed = false
                    tile.update()
                }

                onClicked: {
                    tile.cPressed = false
                    tile.update()
                    console.log("fgMedia dCppTile onMousePressReleased")

                }
                onExited: {
                    console.log("fgMedia dCppTile onExited")
                }
            }
        }

        Rectangle {
            id: button3
            visible: sourceButton3 !== undefined && sourceButton3 !== ""
            width: gridButton.width / gridButton.columns
            height: gridButton.height
            CSize {
                content: ""
            }
            MouseArea {
                anchors.centerIn: button3
                CSize {
                    content: sourceButton3
                }

                id: rButtonMouseArea
                width: buttonWidth
                height: buttonHeight
                enabled: tile.isButton3Enable
                focus: true
                onPressed: {
                    tile.rPressed = true
                    tile.update()
                }

                onReleased: {
                    tile.rPressed = false
                    tile.update()
                }

                onClicked: {
                    console.log("fgMedia lButton onMousePressReleased : source == "+ source)
                }
            }
        }

    }

}
