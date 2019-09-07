import QtQuick 2.0
import QtQuick.Layouts 1.13
Item {
    id:root
    signal takingPicture();
    function takePicture(){
        takePicturePanel.visible = false;
        countDownTimer.start()
    }

    Rectangle{
        id: takePicturePanel
        //visible: false;
        anchors.fill: parent
        color: "#35322f"


        TakePictureButton{
            anchors{
                verticalCenter: parent.verticalCenter
                horizontalCenter:parent.horizontalCenter
            }
            onClicked: {
                root.takePicture();
            }
        }
    }
    //------------
    Rectangle{
        id: countDownPanel
        property int seconds: 4;
        property int defaultSeconds: 4;


        visible: !takePicturePanel.visible
        anchors.fill: parent
        color: "#fc514a"

        RowLayout{
            id:centerCountDownLabelsGroup
            width : parent.width/2
            anchors{
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            Text{
                id:countDown3
                text:"3"
                color:"#FFFFFF"
                font.pixelSize: 42
                font.bold: (countDownPanel.seconds===4)?true:false
                opacity: (countDownPanel.seconds===4)?1:0.4

            }
            Text{
                id:countDown2
                text:"2"
                color:"#FFFFFF"
                font.pixelSize: 42
                font.bold: (countDownPanel.seconds===3)?true:false
                opacity: (countDownPanel.seconds===3)?1:0.4
            }
            Text{
                id:countDown1
                text:"1"
                color:"#FFFFFF"
                font.pixelSize: 42
                font.bold: (countDownPanel.seconds===2)?true:false
                opacity: (countDownPanel.seconds===2)?1:0.4
            }
            Item{
                height: 25
                width: 25
                Image {
                    id: iconPicture
                    source: "qrc:/ressources/camera.png"
                    height: 25
                    width: 25
                    opacity: (countDownPanel.seconds===1)?1:0.4
                }
            }
        }


        Timer {
            id: countDownTimer
            repeat: true
            interval: 1000
            onTriggered: {
                countDownPanel.seconds--;
                if(countDownPanel.seconds === 1){
                    root.takingPicture();
                }
                else if (countDownPanel.seconds === 0) {
                    running = false;
                    countDownPanel.seconds = countDownPanel.defaultSeconds
                    takePicturePanel.visible = true;
                    countDownTimer.stop();

                }
            }
        }
    }
    //----

}
