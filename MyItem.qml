import QtQuick 2.0

Rectangle {
   id: myItem

   signal message(string msg)
   CSize {
      content:  "" + index
   }

   width: 100; height: 50
   onVisibleChanged: {
       console.log("onVisibleChanged: " + visible)
   }

   MouseArea {
       anchors.fill: parent
       onClicked: {
           console.log("myItem onClicked: ")
           myItem.message("myItem clicked!")
       }

       onPressed: {
           console.log("myItem  onPressed: ")
           myItem.message("myItem Pressed!")
       }
   }
}
