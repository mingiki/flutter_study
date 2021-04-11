import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two/constants/common_size.dart';
import 'package:instagram_two/constants/screen_size.dart';
import 'package:instagram_two/widgets/my_progress_indicator.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {

  CameraController _controller;
  Widget _progress = MyProgressIndicator();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
      future: availableCameras(),
      builder: (context, snapshot) {
        if(snapshot.hasData)
          return MyProgressIndicator();

        return Column(
          children: [
            Container(
              width: size.width,
              height: size.width,
              color : Colors.black38,
              child : (snapshot.hasData)? _getPriview(snapshot.data) : _progress,
            ),
            Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(common_s_gap),
                    child: Container(
                      decoration: ShapeDecoration(
                        shape: CircleBorder(
                          side: BorderSide(
                            color: Colors.black38, width: 20
                          )
                        )
                      ),
                    ),
                  ),
                )
            )
          ],
        );
      }
    );
  }

  Widget _getPriview(List<CameraDescription> cameras) {
    _controller = CameraController(cameras[0], ResolutionPreset.medium);

    return FutureBuilder<Object>(
      future: _controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done){
          return ClipRect(
            child: OverflowBox(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Container(
                  width: size.width,
                  height: size.width/_controller.value.aspectRatio,
                  child: CameraPreview(
                      _controller
                  ),
                ),
              ),
            ),
          );
        } else {
         return _progress;
        }

      }
    );
  }
}