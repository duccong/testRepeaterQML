import QtQuick 2.12
import QtQml.Models 2.2

Item {
    id: container
    objectName: "editbox"
    visible : true
    width: 540 // ~DC objectStyler.isWideScreen?540:524;
    height: 1920 // ~DC objectStyler.displayHeight
    property int itemHeight: 120
    property int itemWidth: 80
    property int highlightItem: 0
//    onVisibleChanged: {
//        console.log("editbox - onVisibleChanged: " + visible)
//    }

    Item {
        anchors.fill: parent
        Rectangle{
            color: "black"
            opacity: 0.3
            anchors.fill: parent
        }
        // List
        Flickable {
            id: view
            //            anchors.top: listTitleItem.bottom
            //            anchors.topMargin: 3
            //            //        anchors.bottom: parent.bottom; anchors.bottomMargin: 1
//            width: 6 * itemWidth;
//            height: parent.height
            anchors.fill: parent
            CSize {

            }

            anchors.left: parent.left;
            anchors.right: parent.right
            contentHeight: height;
            contentWidth: {
                fglistView.width
            }
            clip: true

//            onVisibleChanged: {
//                view.contentY = highlightItem * itemHeight
//            }

            ListViewAnimation {
                y:300
                id: fglistView
                width: 10*itemWidth; height: 5*itemHeight// : 0
                highlightMoveDuration: 1
                highlightFollowsCurrentItem: false
                currentIndex: -1
                snapMode: ListView.SnapToItem
                cacheBuffer: 120 * 2
//                numberItemInView: 6
                displayMarginBeginning: 120 * 2
                displayMarginEnd: 120 * 2
//                model: visualModel

                property int dragItemIndex: -1

                displaced: Transition {
                    NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
                }

                model: DelegateModel {
                    id: visualModel
                    model: 15
                    delegate: DelegateAnimation {
                        id: delegateAnimation
                        width:  itemWidth; height: itemHeight
    //                    lineWidth: 0
                        itemComponent: mediaItemComponent
                        indexTopView: 0
                        indexItem: index
                        numberItemInView: 10
                        invisible: !parent.visible
                        orientation: _HORIZONTAL
                        property int visualIndex: DelegateModel.itemsIndex
//                        CSize {

//                        }

                        onXChanged: {
                            console.log("onXChanged: " + x)
                        }

                        Component {
                            id: mediaItemComponent
                            DropItem {
                                id: mediaItem
    //                            property bool pressed: false
                                width: 120; height: itemHeight
                                _parent: fglistView
                                visualIndex: delegateAnimation.visualIndex
                                onItemDrag: {
                                    if (from === to) {
                                        return
                                    }
                                    visualModel.items.move(from,to)
                                }
                            }//[END]--mediaItem
                        }//[END]--mediaItemComponent
                    }
                }

                orientation: ListView.Horizontal

                visible: container.visible
            }

        }
    }
}
