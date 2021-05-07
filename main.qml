import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

Window {
    id: main_win
    objectName: "main_win"
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    property int linesOfLog: 10
    property int contentWidth: 100
    property int contentHeight: 50
    property bool isShow: false
    property bool test1: false

    signal mainClicked(var var1,var var2)

    Rectangle {
        id: _mouseAreaAdd
        width: 100
        height: 50
        visible: true
        anchors.right: parent.right
        CSize {
            content: "ADD"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (isShow) {
//                    commonPanelPopup.hide()
                } else {
//                    commonPanelPopup.show(1)
                }
                isShow = !isShow
            }
        }
    }

    Rectangle {
        id: _mouseAreaAdd2
        width: 100
        height: 50
        visible: true
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        CSize {
            content: "normal list"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("_mouseAreaAdd2 onClicked: 1: " + _mouseAreaAdd2.Window.title)
                mainClicked(1,2)
                /*
//                console.log("itemName at 1: " + normalListView.contentItem.children[1].itemName)
//                if (!test1) {
//                    popup.parent = normalListView.contentItem.children[1]
//                } else {
//                    popup.parent = normalListView.parent
//                }

//                test1 = !test1

////                console.log("get objectName: " + normalListView.model.get(1).test())
//                console.log("objectName: " + normalListView.model[1].name)
//                console.log("get itemName: " + normalListView.itemAt(1).itemName)
//                console.log("_test: 1: " + normalListView.itemAt(1)._test)
//                normalListView.itemAt(1)._test = !normalListView.itemAt(1)._test
//                console.log("_test: !1: " + normalListView.itemAt(1)._test)
//                console.log("number: " + normalListView.itemAt(1).number)
//                normalListView.model.get(1).test()
//                normalListView.contentItem.children[1].test()
//                normalListView.contentItem.children[1].model.name = "ABC"
//                normalListView.model.setProperty(0,"name","ABC");
                */

            }
        }
    }

    FgMedia {

    }

//    CommonPanelPopup {
//        id: commonPanelPopup
//        visible: falsez

//    }

    /*========   START - TEST ANIMATION LIST  *========*/
/*
    MediaList {
        id: commonPanelPopup
        visible: false
    }
*/
    /*========   END - TEST ANIMATION LIST  *========*/

    /*========   START - TEST ANIMATION BOX  *========*/
/*
    Box {
        visible: isShow
    }
*/
    /*========   END - TEST ANIMATION BOX  *========*/

    /*========   START - Test normal list   *========*/
/*
    ListModel {
        id: listModel
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
    }

    property        variant             shortcutModel                       : [
        {"name": "N1", "number": "21", "icon": "", "iconUrl": "", "iconUrlDay": "", "iconUrlNight": "", "isColorIcon": false, "shortcutText": "", "isshortcut": false, "isPad": false, "shortcutTextId":"ID_"}
        , {"name": "N2", "number": "24", "icon": "", "iconUrl": "", "iconUrlDay": "", "iconUrlNight": "", "isColorIcon": false, "shortcutText": "", "isshortcut": false, "isPad": false, "shortcutTextId":"ID_"}
        , {"name": "N3", "number": "35", "icon": "", "iconUrl": "", "iconUrlDay": "", "iconUrlNight": "", "isColorIcon": false, "shortcutText": "", "isshortcut": false, "isPad": false, "shortcutTextId":"ID_"}
    ]

    ListView {
        id: normalListView
        width: 180*3; height: 180
        orientation: ListView.Horizontal
        cacheBuffer: 180*2
        model: shortcutModel
        delegate: normalListViewComponent
        CSize {

        }
    }

    Rectangle {
        id: indicator
        parent: normalListView.children[0] !== undefined ? normalListView.children[0] : normalListView
//        anchors.horizontalCenter: parent.horizontalCenter
        border.width: 5
        radius: 5
        color: "YELLOW"
        width: 100
        height: 20
        y: 120
        z: 2
        x: (normalListView.width/2) - indicator.width/2 + normalListView.contentX
    }

    Component {
        id: normalListViewComponent
        Item {
            property string itemName: (modelData.name!==undefined?modelData.name:"")
            property bool isTest: false
            width: 180; height: 180
            z: index !== 1? 2 : 0
            Rectangle {
                objectName: index
                anchors.fill: parent

                CSize {

                }

                Text {
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    width: 180; height: 100
                    text: modelData.name + ": " + modelData.number
                }

                Rectangle {
                    anchors.centerIn: parent
                    width: 120
                    height: 120
//                    anchors.fill: parent
                    opacity: 0.5
                    color: "BLUE"
                }

                function test() {
                    console.log("index: " + index + " -> Test")
                }
            }
        }
    }



    Rectangle {
        id: popup
        anchors.centerIn: parent
        width: 100
        height: 100
        opacity: 0.8
        color: "GREEN"
        parent: normalListView.parent
        z:2
    }

*/
    /*========   END - Test normal list   *========*/

    /*========   START - Test dynamic list   *========*/
/*
    ListView {
        y:180
//        x: y
        id: animalList
        width: 100*6; height: 100
        orientation: ListView.Horizontal
        cacheBuffer: 100*2
        model: animalModel
        spacing: 10
        snapMode: ListView.SnapToItem
        delegate: Item {
            width: 100
            height: 100
            CSize {
                content: "index: " + index + "\n type: " + model.type + "\n size: " + model.size
            }

            ListView.onAdd: {
                console.log("ListView.onAdded: index: " + index)
            }

            ListView.onRemove: {
                console.log("ListView.onRemoved: index: " + index)
            }
        }
        CSize {
            content: ""
        }
    }
*/
    /*========   END - Test dynamic list   *========*/
}
