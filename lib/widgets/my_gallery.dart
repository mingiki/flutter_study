import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two/models/camera_state.dart';
import 'package:instagram_two/models/gallery_state.dart';
import 'package:instagram_two/screens/share_post_screen.dart';
import 'package:local_image_provider/device_image.dart';
import 'package:local_image_provider/local_image.dart';
import 'package:provider/provider.dart';

class MyGallery extends StatefulWidget {
  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryState>(
      builder: (BuildContext context , GalleryState galleryState, Widget child){
        return GridView.count(
            crossAxisCount: 3,
            children: getImages(galleryState)
        );
      },
    );
  }


  List<Widget> getImages(GalleryState galleryState){
    return galleryState.images.map((localImage) => InkWell(
        onTap: () async{
          Uint8List bytes = await localImage.getScaledImageBytes(galleryState.localImageProvider, 0.3);

          final String timeInMilli = DateTime.now().microsecondsSinceEpoch.toString();
          CameraState cameraState;
          try {
            XFile pictureTaken = await cameraState.controller.takePicture();
            File imageFile = File(pictureTaken.path);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SharePostScreen(
                    imageFile
                )
            ));

          } catch (e) {

          }
        },
        child: Image(
          image: DeviceImage(localImage),
          fit: BoxFit.cover
        ))).toList();
  }


}
