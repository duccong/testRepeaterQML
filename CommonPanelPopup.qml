import QtQuick 2.12

Item {
    // anination
    id: container
    property int animateDuration167: 167
    property int animateDuration333: 333
    property int animateDuration666: 666
    property int animateDuration500: 500
    property int animateDuration1000: 1000
    property var easeOut100: [0, 0, 0, 1, 1, 1]
    property var easeIn75: [0.75, 0, 1, 1, 1, 1]
    property var easeInOut2525: [0.25, 0, 0.75, 1, 1, 1]
    property var easeInOut2575: [0.25, 0, 0.25, 1, 1, 1]
    property var easeInOut25100: [0.25, 0, 0.0, 1, 1, 1]

    property int speedDown: 1

    property Item itemTitlePopup
    property Item itemBackgroundPopup
    property Item itemContentPopup

    property bool isTransitionPanelRunning: false

    signal transitionShowStart();
    signal transitionHideStart();
    signal transitionShowEnd();
    signal transitionHideEnd();

    onIsTransitionPanelRunningChanged: {
        console.log("onIsTransitionPanelRunningChanged: " + isTransitionPanelRunning)
    }

    function startShowPanel() {
        console.log("[CommonPanelPopup] showPanelPopup")
        if (parallelAnimationOut.running) {
            parallelAnimationOut.stop()
        }
        parallelAnimationIn.restart()
    }

    function startHidePanel() {
        console.log("[CommonPanelPopup] hidePanelPopup")
        if (parallelAnimationIn.running) {
            parallelAnimationIn.stop()
        }
        parallelAnimationOut.restart()
    }

    ParallelAnimation {
        id: parallelAnimationIn
        //        running: true
        // [S] Title
        YAnimator {
            target: itemTitlePopup;
            from: -itemTitlePopup.height;
            to: 0; duration: animateDuration666 * speedDown;
            easing.type: Easing.Bezier;
            easing.bezierCurve: easeInOut25100
        }
        OpacityAnimator {
            target: itemTitlePopup;
            from: 0;
            to: 1;
            duration: animateDuration500 * speedDown;
            easing.type: Easing.Bezier;
            easing.bezierCurve: easeIn75
        }
        // [E] Title

        // [S] Background
        YAnimator {
            target: itemBackgroundPopup;
            from: -itemBackgroundPopup.height;
            to: 0 //listTitleItem.height + 1;
            duration: animateDuration666 * speedDown;
            easing.type: Easing.Bezier;
            easing.bezierCurve: easeInOut25100
        }
        OpacityAnimator {
            target: itemBackgroundPopup;
            from: 0;
            to: 1;
            duration: animateDuration333 * speedDown;
            easing.type: Easing.Bezier;
            easing.bezierCurve: easeInOut2525
        }
        // [E] Background

        // [S] Content
        YAnimator {
            target: itemContentPopup;
            from: -itemContentPopup.height;
            to: itemTitlePopup.height + 1;
            duration: animateDuration666 * speedDown;
            easing.type: Easing.Bezier;
            easing.bezierCurve: easeInOut25100
        }
        OpacityAnimator {
            target: itemContentPopup;
            from: 0;
            to: 1;
            duration: animateDuration500 * speedDown;
            easing.type: Easing.Bezier;
            easing.bezierCurve: easeInOut25100
        }
        // [E] Background
        onStarted: {
            console.log("parallelAnimationIn onStarted")
            container.visible = true
            transitionShowStart();
            isTransitionPanelRunning = true;
        }

        onStopped: {
            console.log("parallelAnimationIn onStopped")
            transitionShowEnd()
            isTransitionPanelRunning = false;
        }
    }

    ParallelAnimation {
        id: parallelAnimationOut

        OpacityAnimator {
            target: itemTitlePopup;
            from: 1;
            to: 0;
            duration: animateDuration500 * speedDown;
            easing.type: Easing.Bezier;
            easing.bezierCurve: easeInOut2525
        }

        YAnimator {
            target: itemTitlePopup;
            from: 0
            to: -itemTitlePopup.height;
            duration: animateDuration666 * speedDown;
            easing.type: Easing.Bezier;
            easing.bezierCurve: easeInOut25100
        }
        // [E] Title

        // [S] Background
        YAnimator {
            target: itemBackgroundPopup;
            from: 0;
            to: -itemBackgroundPopup.height;
            duration: animateDuration666 * speedDown;
            easing.type: Easing.Bezier;
            easing.bezierCurve: easeInOut25100
        }
        OpacityAnimator {
            target: itemBackgroundPopup;
            from: 1;
            to: 0;
            duration: animateDuration333 * speedDown;
            easing.type: Easing.Bezier;
            easing.bezierCurve: easeInOut2525
        }
        // [E] Background

        // [S] Content
        YAnimator {
            target: itemContentPopup;
            from: itemTitlePopup.height + 1;
            to: -itemContentPopup.height;
            duration: animateDuration666 * speedDown;
            easing.type: Easing.Bezier;
            easing.bezierCurve: easeInOut25100
        }
        OpacityAnimator {
            target: itemContentPopup;
            from: 1;
            to: 0;
            duration: animateDuration500 * speedDown;
            easing.type: Easing.Bezier;
            easing.bezierCurve: easeInOut25100
        }
        // [E] Background

        onStarted: {
            console.log("parallelAnimationOut onStarted")
            transitionHideStart();
            isTransitionPanelRunning = true;
        }

        onStopped: {
            console.log("parallelAnimationOut onStopped")
            container.visible = false
            transitionHideEnd()
            isTransitionPanelRunning = false;
        }
    }
}
