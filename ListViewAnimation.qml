import QtQuick 2.4

ListView {
    id: lv

    property int numberItemInView: 6
    property int indexTopList: 0
    property int indexEndList: Math.min(indexTopList + numberItemInView -1, lv.count-1)
    property int heightItem: 120
    property int widthItem: 500
    property bool invisible

    width: widthItem
    height: numberItemInView * heightItem - 2
    snapMode: ListView.SnapToItem
    //interactive: !invisible

//    onIndexTopListChanged: {
//        console.log("indexTopList: " + indexTopList)
//    }

//    onIndexEndListChanged: {
//        console.log("indexEndList: " + indexEndList)
//    }

    onContentYChanged: {
        var tmp_index_top_list = indexAt(50, contentY + 10)
        if(tmp_index_top_list < 0) tmp_index_top_list = 0
        indexTopList = tmp_index_top_list
    }


    onInvisibleChanged: {
        if(lv.moving) {
            //console.log("List View Stoped")
            lv.cancelFlick()
            positionViewAtIndex(indexTopList, ListView.Beginning)
        }
    }

    onVisibleChanged: {
        if(lv.moving) {
            //console.log("List View Stoped")
            lv.cancelFlick()
            positionViewAtIndex(indexTopList, ListView.Beginning)
        }
    }
}
