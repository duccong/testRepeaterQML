import QtQuick 2.0

Item {
    id: container
    width: 80
    height: 120
    property Item _parent

//    property var posOnBoard: undefined
    property var targetPos: undefined
    property var targetIndex: undefined

    CSize {
        content: "DragItem"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        //        anchors.fill: parent
        drag.target: _itemRect
        state: pressed ? "pressed" : "release"

        onStateChanged: {
            console.log("onStateChanged" + state)
        }

        onReleased: {
            if (_itemRect.Drag.target !== null) {
                console.log("Droped");
                parent = _itemRect.Drag.target
//                posOnBoard = parent.pos
//                console.log("posOnBoard: " + posOnBoard)
            } else {
                console.log("Can'drop");
                parent = _parent !== undefined ? _parent : undefined
//                posOnBoard = undefined;
            }

            //
        }

        Rectangle {
            id: _itemRect
            //            anchors.fill: parent
            width: 30
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "LIGHTBLUE"
            border.width: 1
            border.color: "BLACK"

            Drag.active: mouseArea.drag.active
            Drag.hotSpot.x: width/2
            Drag.hotSpot.y: height/2
            Drag.keys: ["A"]
            Text {
                id: _text
                text: "TEST - 1"
                anchors.centerIn: parent
                font.pixelSize: 15
            }

            states: State {
                when: mouseArea.drag.active
                //                ParentChange { target: tile; parent: root }
                AnchorChanges { target: _itemRect; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
            }
        }

        Rectangle {
            id: bullet
            width: 10
            height: 10
            color: mouseArea.state === "pressed" ? "pressed" : "release"
        }

        states: [
            State {
                name: "release"
                PropertyChanges {
                    target: bullet
                    x:7
                    y:7
                }
            },
            State {
                name: "pressed"
                PropertyChanges {
                    target: bullet
                    x: targetPos !== undefined ? targetPos.x : 7
                    y: targetPos !== undefined ? targetPos.y : 7
                }
            }
        ]

    }
}
