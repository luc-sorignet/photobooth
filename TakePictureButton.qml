import QtQuick 2.0


Rectangle{
    id:takePictureBtn
    signal clicked(var mouse);
        height: 50
        width: height
        radius: height
        color: "#fc514a"

        Image{
            id:cameraIcon
            source: "qrc:/ressources/camera.png"
            height: 25
            width: 25
            anchors{
                verticalCenter: parent.verticalCenter
                horizontalCenter:parent.horizontalCenter
            }
        }
      Rectangle{
          id:blackHover
          visible: takePictureMouseArea.pressed
          color:"#000000"
          opacity: 0.4;
          anchors.fill: parent
          radius: parent.radius

      }
        MouseArea{
            id:takePictureMouseArea
            anchors.fill: parent;
            onClicked: takePictureBtn.clicked(mouse);
        }
    }

