import QtQuick 2.12
import QtQml.Models 2.1
Item {
    property Item _parent
    id: container
    width: 30
    height: 30

    property int visualIndex: 0

    signal itemDrag (var from, var to)
    signal activeDrag(var activeValue)


    DropArea {

        id: dragTarget

        width: container.width
        height: container.height
        objectName: "DropItem"
//        keys:["A"]
        onContainsDragChanged: {
//            console.log("onContainsDragChanged: " + containsDrag)
        }

        onEntered: {
            console.log("1dropItem: onEntered: from: " + drag.source.visualIndex + " - to: " + _rect.visualIndex)
            container.itemDrag(drag.source.visualIndex, _rect.visualIndex)
        }

        Binding { target: _rect; property: "visualIndex"; value: visualIndex }

        Rectangle {
            property int visualIndex: 0
            id: _rect
            width: container.width
            height: container.height
            anchors {
                horizontalCenter: parent.horizontalCenter;
                verticalCenter: parent.verticalCenter
            }
            border.width: 1
            border.color: "BLACK"
            //        opacity: 0.1
            color: "LIGHTGREEN"
            CSize {
                content: "vs" + visualIndex + " - idx: " + index
            }

            DragHandler {
                id: dragHandler
                onActiveChanged: {
                    console.log("onActiveChanged: " + active)
                    container.activeDrag(active)
                }
            }

            Drag.active: dragHandler.active
            Drag.source: _rect
            Drag.hotSpot.x: _rect.width/2
            Drag.hotSpot.y: _rect.height/2



            states: [
                State {
                    when: _rect.Drag.active
                    ParentChange {
                        target: _rect
                        parent: _parent
                    }

                    AnchorChanges {
                        target: _rect
                        anchors.horizontalCenter: undefined
                        anchors.verticalCenter: undefined
                    }
                }
//                ,State {
//                    when: !_rect.Drag.active
//                    PropertyChanges {
//                        target: _rect
//                        parent: container
//                    }
////                    AnchorChanges {
////                        target: _rect
////                        anchors.horizontalCenter: _parentDrop
////                        anchors.verticalCenter: _parentDrop
////                    }
//                    PropertyChanges {
//                        target: _rect
//                        x: 0
//                        y: 0
//                    }
//                }
            ]
        }
    }
}

