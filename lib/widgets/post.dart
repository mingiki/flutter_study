import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two/constants/common_size.dart';
import 'package:instagram_two/constants/screen_size.dart';
import 'package:instagram_two/widgets/Comment.dart';
import 'package:instagram_two/widgets/my_progress_indicator.dart';
import 'package:instagram_two/widgets/rounded_avator.dart';

class Post extends StatelessWidget {
  final int index;

  Post(this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption()
      ],
    );
  }

  Widget _postCaption(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap , vertical : common_xss_gap),
      child: Comment(
          showImage: false,
          username: 'testingUser',
          text: 'I have money!!!!',
          dateTime: DateTime.now(),
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
        padding: const EdgeInsets.only(left: common_gap),
        child: Text(
            '12000 likes' ,
            style : TextStyle(fontWeight: FontWeight.bold)
        ),
      );
  }

  Widget _postHeader() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(common_xss_gap),
          child: RoundedAvatar(size : 40),
        ),
        Expanded(child : Text('username') ),
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          )
        )
      ],
    );
  }

  CachedNetworkImage _postImage() {
    return CachedNetworkImage(
        imageUrl: 'https://picsum.photos/id/$index/200/200',
        placeholder: (BuildContext context , String url){
          return MyProgressIndicator(containerSize: size.width);
        },
        imageBuilder: (BuildContext context , ImageProvider imageProvider){
          return AspectRatio(aspectRatio: 1, child : Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover)
              ),
            )
          );
        },
      );
  }

  Row _postActions() {
    return Row(
      children: <Widget>[
        IconButton(
            icon: ImageIcon(AssetImage('assets/images/bookmark.png')),
            color: Colors.black87,
            onPressed: null
        ),
        IconButton(
            icon: ImageIcon(AssetImage('assets/images/comment.png')),
            color: Colors.black87,
            onPressed: null
        ),
        IconButton(
            icon: ImageIcon(AssetImage('assets/images/direct_message.png')),
            color: Colors.black87,
            onPressed: null
        ),
        Spacer(),
        IconButton(
            icon: ImageIcon(AssetImage('assets/images/heart_selected.png')),
            color: Colors.black87,
            onPressed: null
        ),
      ],
    );
  }

}



