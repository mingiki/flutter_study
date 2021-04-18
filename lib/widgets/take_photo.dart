import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two/constants/common_size.dart';
import 'package:instagram_two/constants/screen_size.dart';
import 'package:instagram_two/models/camera_state.dart';
import 'package:instagram_two/screens/share_post_screen.dart';
import 'package:instagram_two/widgets/my_progress_indicator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

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
    return Consumer<CameraState>(
      builder: (BuildContext context, CameraState cameraState, Widget child){
        return Column(
          children: [
            Container(
              width: size.width,
              height: size.width,
              color : Colors.black38,
              child : (cameraState.isReadyToTakePhoto)? _getPriview(cameraState) : _progress,
            ),
            Expanded(
                child: InkWell(
                  onTap: (){
                    if(cameraState.isReadyToTakePhoto){
                      _attemptTakePhoto(cameraState, context);
                    }
                  },
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

  Widget _getPriview(CameraState cameraState) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            width: size.width,
            height: size.width/ cameraState.controller.value.aspectRatio,
            child: CameraPreview(
                cameraState.controller
            ),
          ),
        ),
      ),
    );
  }

  void _attemptTakePhoto(CameraState cameraState, BuildContext context) async {
    final String timeInMilli = DateTime.now().microsecondsSinceEpoch.toString();

    // final String postKey = getNewPostKey(Provider.of<UserModelState>(context, listen: false).userModel);

    try {
      // final path = join( (await getTemporaryDirectory()).path, '$timeInMilli.png');

      XFile pictureTaken = await cameraState.controller.takePicture();
      File imageFile = File(pictureTaken.path);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SharePostScreen(
          imageFile
        )
      ));

    } catch (e) {

    }
  }
}