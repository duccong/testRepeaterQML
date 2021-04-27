import QtQuick 2.11

Item {
    id: container

    // ----- Orientation -----
    readonly property int _VERTICAL: 0
    readonly property int _HORIZONTAL: 1

    property var easeIn75: [0.75, 0.00, 1.00, 1.00, 1.00, 1.00]
    property var easeIn25Out25: [0.25, 0.00, 0.75, 1.00, 1.00, 1.00]
    property var easeOut100: [0.00, 0.00, 0.00, 1.00, 1.00, 1.00]

    property var easeIn100: [1.00, 0.00, 1.00, 1.00, 1.00, 1.00]
    property var easeOut75: [0.00, 0.00, 0.25, 1.00, 1.00, 1.00]


    property alias inAnimationConfig: startAnimation
    property alias outAnimationConfig: outAnimation
    property alias contentLoader: loaderDelegateContent

    property Component itemComponent
    property Item line
    property int lineWidth: 0
    property int indexTopView: -1
    property int indexItem: -2
    property int numberItemInView: 6
    property bool inView: (indexItem >= indexTopView) && (indexItem <= (indexTopView + numberItemInView -1))
    property int positionInView: indexItem - indexTopView
    property bool invisible


    property int orientation: _VERTICAL

    property int speedDown: 1

    opacity: 1

    onInViewChanged: {
        // in Case add new item
        //console.log(" onInViewChanged : " + indexItem)
        stopAnimation()
        if(invisible) {
            if(inView) {
                // Hide item in view for wait List view run In animation
                if(container.opacity !== 0) {
                    reset()
                }
            } else {
                // Show item if Out of View
                if(container.opacity !== 1) {
                    resetToShow()
                }
            }
        } else {
            // Error case: Make sure : Show item if Out of View
            if(container.opacity !== 1) {
                resetToShow()
            }
        }
    }

    onInvisibleChanged: {
        if(!invisible) {
            if(inView) {
                outAnimationTimer.stop()
                animationTimer.interval = (positionInView >= 0) ? (positionInView*100) : 0
                //console.log("In interval: " + animationTimer.interval)
                animationTimer.restart()
            }
        } else {
            if(inView) {
                animationTimer.stop()
                outAnimationTimer.interval = (positionInView >= 0) ? (positionInView*33) : 0
                //console.log("Out interval: " + outAnimationTimer.interval)
                outAnimationTimer.restart()
            }
        }
    }

    Item {
        id: layoutItem
        width: parent.width
        height: parent.height
        y: 0

        Loader {
            id: loaderDelegateContent
            anchors.fill: parent
            sourceComponent: itemComponent
            onLoaded: {
                if (loaderDelegateContent !== null && loaderDelegateContent !== undefined) {
                    if (loaderDelegateContent.item !== null && loaderDelegateContent.item !== undefined) {
                        if (loaderDelegateContent.item.line !== null && loaderDelegateContent.item.line !== undefined) {
                            line = loaderDelegateContent.item.line
                        }
                    }
                }

                stopAnimation()
                if(!visible) {
                    if(inView) {
                        // Hide item in view for wait List view run In animation
                        if(container.opacity !== 0) {
                            reset()
                        }
                    } else {
                        // Show item if Out of View
                        if(container.opacity !== 1) {
                            resetToShow()
                        }
                    }
                } else {
                    // Error case: Make sure : Show item if Out of View
                    if(container.opacity !== 1) {
                        resetToShow()
                    }
                }
            }
        }

    }

    function stopAnimation() {
        if(startAnimation.running) {
            startAnimation.complete()
        }
        if(outAnimation.running) {
            outAnimation.complete()
        }
    }

    function requestInAnimation() {
        outAnimation.complete()
        startAnimation.restart();
    }

    function requestOutAnimation(){
        startAnimation.complete()
        outAnimation.restart()
    }

    function reset() {
        stopAnimation()
        container.opacity = 0
        layoutItem.y = 100
        if(line) {
            line.width = 0
        }
    }

    function resetToShow() {
        stopAnimation()
        container.opacity = 1
        layoutItem.y = 0
        if(line) {
            line.width = lineWidth
        }
    }

    Timer {
        id: animationTimer

        interval: (positionInView >= 0) ? (positionInView*100) : 0
        onTriggered: {
            requestInAnimation()
        }
    }
    Timer {
        id: outAnimationTimer

        interval: (positionInView >= 0) ? (positionInView*33) : 0
        onTriggered: {
            requestOutAnimation()
        }
    }

    ParallelAnimation {
        id: startAnimation

        OpacityAnimator {
            target: container
            from: 0
            to: 1
            duration: 500 * speedDown
            easing.type: Easing.Bezier
            easing.bezierCurve: easeIn75
        }

        SequentialAnimation {
            PauseAnimation {
                duration: 100  * speedDown
            }

            XAnimator {
                target: layoutItem
                from: -100
                to: 0
                duration: orientation !== _VERTICAL ? 500  * speedDown : 0
                easing.type: Easing.Bezier
                easing.bezierCurve: easeOut100
            }

            YAnimator {
                target: layoutItem
                from: -100
                to: 0
                duration: orientation === _VERTICAL ? 500  * speedDown : 0
                easing.type: Easing.Bezier
                easing.bezierCurve: easeOut100
            }
        }

        SequentialAnimation {
            PauseAnimation {
                duration: 133  * speedDown
            }
            NumberAnimation {
                target: line
                property: "width"
                from: 0
                to: lineWidth
                duration: 500  * speedDown
                easing.type: Easing.Bezier
                easing.bezierCurve: easeOut100
            }
        }
    }

    ParallelAnimation {
        id: outAnimation

        OpacityAnimator {
            target: container
            from: 1
            to: 0
            duration: 167  * speedDown
            easing.type: Easing.Bezier
            easing.bezierCurve: easeOut75
        }

        XAnimator {
            target: layoutItem
            from: -100
            to: 0
            duration: orientation !== _VERTICAL ? 167  * speedDown : 0
            easing.type: Easing.Bezier
            easing.bezierCurve: easeIn100
        }

        YAnimator {
            target: layoutItem
            from: -100
            to: 0
            duration: orientation === _VERTICAL ? 167  * speedDown : 0
            easing.type: Easing.Bezier
            easing.bezierCurve: easeIn100
        }

        NumberAnimation {
            target: line
            property: "width"
            from: lineWidth
            to: 0
            duration: 167  * speedDown
            easing.type: Easing.Bezier
            easing.bezierCurve: easeIn100
        }
    }
}
