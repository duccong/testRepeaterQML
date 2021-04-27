import QtQuick 2.12

CommonPanelPopup {
    id: container
    objectName: "fgMediaList"
    visible : true
    width: 540 // ~DC objectStyler.isWideScreen?540:524;
    height: 1920 // ~DC objectStyler.displayHeight

    signal cancelClicked()
    signal itemClicked(variant _value)

    // style properties
    property alias listTitle: titleText.text

    property var bgColor
    property var titleBgColor
    property var generalTextColor
    property var buttonImageOnlyColor
    property var listLineColor
    property int xIndexParentValue: 0 //~DC //parent === null ? 0 : parent.xIndexValue
    property int scrollDirectionValue: 0 //~DCparent === null ? 0 : parent.scrollDirectionValue
    property var mediaSubscription: 0 //~DC parent === null ? undefined : parent.onlineMediaSubscription

    // properties
    property bool animationPermission: false
    property int animationEasing: Easing.Linear
    property int animationDuration: 250
    property string dayModeValue: "day"
    property var dayMode:  "day" // ~DC parent === null ? undefined : parent.dayModeType
    property var deviceListModelData: 10 //parent === null ? undefined : parent.deviceListModel
    property int itemShowCount: 5
    property real itemHeight: 60
    property bool cancelButtonVisble: true
    property var onlineMediaCountListQml : 3 // ~DC parent === null ? undefined : parent.onlineMediaCountListMediaListQml
    property string trSource: "Source" // ~DC lingualText.text("ID_06973", "Source")
    property string trGetMoreApps: "Get more apps"

    itemTitlePopup: listTitleItem
    itemBackgroundPopup: itemBackground
    itemContentPopup: view

    onVisibleChanged: {
        console.log("[MediaList] onVisibleChanged: " + visible)
        if (visible) {
            isShowing = true
        }
    }

    onCancelClicked: {
        console.log("onCancelClicked : parent.visible : "+ parent.visible)
    }

    function show(xIndex) {
//        container.dayModeValue = parent.dayModeType
//        console.log("fgMediaList : show : container.dayModeValue : "+container.dayModeValue)
        container.visible = true
        startShowPanel()
    }

    function hide() {
        console.log("[MediaList] hide : "+ parent.visible)
//        container.visible = false
        startHidePanel()
    }

    onTransitionHideEnd: {
        console.log("[MediaList] onTransitionHideEnd : "+ parent.visible)

    }



    function itemClick(_cmd, _data, _data2) {
        parent.itemClick(_cmd, _data, _data2)
    }

    // Background
    Item {
        id: itemBackground
        anchors.fill: parent
        Rectangle {
            id: bg
            visible: true
            anchors.fill: parent
            color: "GREEN"
            opacity: 0.5
        }
        MouseArea {
            id: bgArea
            visible: true
            anchors.fill: parent
            onPressed : {
                console.log("   onPressed  ")
                mouse.accepted = false;
            }
            onClicked : {
                mouse.accepted = false;
            }
            onExited: {
                mouse.accepted = false;
            }
        }
    }

    //title
    Item {
        id: listTitleItem
        anchors.top: parent.top; anchors.topMargin: 3
        anchors.left: parent.left; anchors.leftMargin: 3
        width: 518;
        height: 114
        opacity: 0
        y:-height


        Rectangle {
            id: itemBg
            visible: true
            anchors.fill: parent
            color: "RED"
        }

        Item {
            id: titleTextBox
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 17
            width: 364; height: parent.height
            Text {
                id: titleText
                anchors.top: parent.top
                width: parent.width; height: parent.height
                maximumLineCount: 2
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 36
                wrapMode: Text.Wrap
                elide : Text.ElideRight
                color: "BLACK"
                text: trSource // ID_09185 : SOURCE
                //                font.family: fontSB
            }
        }

        Rectangle {
            id: cancel
            visible: cancelButtonVisble
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right; anchors.rightMargin: 12
            width: 90; height: 90
            //            autoStyle: false
            //            source: objectStyler.imageOfRootPath("home_main", "cancel", "image")
            color: "BLUE" // ~DC buttonImageOnlyColor[styleState]
        }
        MouseArea {
            id: cancelButtonArea
            visible: (cancel.visible && cancel.enabled)
            anchors.top: parent.top
            anchors.right: parent.right
            width: 117; height: 114 //120, 120
            onPressed : {
                cancel.pressed = true
            }
            onClicked: {
                if(cancel.pressed === true) {
                    cancel.pressed = false
                    container.cancelClicked()
                    container.visible = false
                }
            }
            onExited:  {
                cancel.pressed = false
            }
        }
    }
    property int highlightItem: 3
    // List
    Flickable {
        id: view
        anchors.top: listTitleItem.bottom
        anchors.topMargin: 3
        //        anchors.bottom: parent.bottom; anchors.bottomMargin: 1
        width: parent.width;
        height: 6*itemHeight
        anchors.left: parent.left;
        anchors.right: parent.right
        contentWidth: width;
        contentHeight: {
            fglistView.height
        }
        clip: true

        onVisibleChanged: {
            view.contentY = highlightItem * itemHeight
        }

        ListViewAnimation {
            id: fglistView
            width: parent.width; height: 10 * itemHeight// : 0
            highlightMoveDuration: 1
            highlightFollowsCurrentItem: false
            currentIndex: -1
            snapMode: ListView.SnapToItem
            cacheBuffer: 120 * 2
            numberItemInView: 6
            displayMarginBeginning: 120 * 2
            displayMarginEnd: 120 * 2
            model: 50



//            visible: container.visible
            delegate: DelegateAnimation {
                width:  parent.width; height: itemHeight
                lineWidth: parent.width
                itemComponent: mediaItemComponent
                indexTopView: highlightItem
                indexItem: index
                numberItemInView: 6
                invisible: !container.visible
                line: lineBottom

                Component {
                    id: mediaItemComponent
                    Item {
                        id: mediaItem
                        property bool pressed: false
                        width: 120; height: itemHeight
                        Text {
                            anchors.fill: parent
//                            CSize {

//                            }

                            id: name
                            text: index + "-"+ highlightItem + " - index"
                            font.pointSize: 24
                        }
                    }//[END]--mediaItem
                }//[END]--mediaItemComponent

                Rectangle {
                    id: lineBottom
                    width: parent.width
                    height: 3
                }
            }

        }
    }
}
