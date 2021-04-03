import 'package:flutter/material.dart';
import 'package:instagram_two/constants/screen_size.dart';

class ProfileSideMenu extends StatelessWidget {

  final double menuWidth;

  const ProfileSideMenu({Key key, this.menuWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: menuWidth,
        child: Column(
          crossAxisAlignment : CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Settings',  style : TextStyle(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.black87),
              title: Text('Sign Out'),
            )
          ],
        ),
      ),
    );
  }
}
