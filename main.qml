import QtQuick 2.9
import QtQuick.Window 2.2
import Qt.labs.platform 1.1
import QtQuick.VirtualKeyboard 2.2
import QtMultimedia 5.11



Window {
    id: mainwindow
    visible: true
    width: 800
    height: 600
    title: qsTr("Photo Booth")
    visibility: "Windowed"
        MenuBar {
        id: menuBar
           Menu {
               title: qsTr("&File")
               MenuItem {
                   text: qsTr("&Take a photo")
                   shortcut: "Ctrl+T"
                   onTriggered:{
                       bottomPanel.takePicture();
                   }
               }
               MenuItem {
                   text:(mainwindow.visibility===Window.Windowed)? qsTr("Toggle &Fullscreen"):qsTr("Toggle &Windowed")
                   shortcut: "Ctrl+F"
                   onTriggered:{
                       if(mainwindow.visibility===Window.FullScreen){
                           mainwindow.showNormal()
                       }
                       else{
                           mainwindow.showFullScreen()
                       }
                   }
               }

           }
       }



    Camera {
        id:camera
        videoRecorder.outputLocation: "./"
    }

    Rectangle{
     anchors{
         top:parent.top
         right:parent.right
         left:parent.left
         bottom:bottomPanel.top
     }
     color: "#000000"

     Flipable {
         id:flipable
         anchors.fill: parent
         VideoOutput {
             id: videoOutput
             source: camera
             anchors.fill: parent
             fillMode:VideoOutput.PreserveAspectCrop
         }
         transform: Rotation {
                 id: rotation
                 origin.x: flipable.width/2
                 origin.y: flipable.height/2
                 axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                 angle: 180    // the default angle
             }
     }


     Rectangle{
         height: 80;
         anchors{
             right:parent.right
             left:parent.left
             bottom:parent.bottom
         }
         color: "#000000";
         opacity: 0.4;
         visible: false;

     }
    }


     BottomPanel{
         id: bottomPanel
         anchors{
             bottom:parent.bottom
             right:parent.right
             left:parent.left
         }
         height: 60
         onTakingPicture:{
            flash.flashScreen();
            camera.imageCapture.capture();
         }
    }

     Rectangle {
         id: flash
         width: parent.width
         height: parent.height
         color: "#FFFFFF"
         visible: false
         function flashScreen(){
            flashanim.start();
         }
         OpacityAnimator {
             id:flashanim;
             target: flash;
             from: 1;
             to: 0;
             duration: 500
             onStarted: {
                flash.visible = true
             }

             onStopped:{
                flash.visible = false;
             }
         }
     }

}
