import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two/constants/screen_size.dart';
import 'package:instagram_two/screens/camera_screen.dart';
import 'package:instagram_two/screens/feed_screen.dart';
import 'package:instagram_two/screens/profile_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label : ''),
    BottomNavigationBarItem(icon: Icon(Icons.search), label : ''),
    BottomNavigationBarItem(icon: Icon(Icons.add), label : ''),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label : ''),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label : '')
  ];

  int _selectedIndex = 0;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  static List<Widget> _screens = <Widget>[
    FeedScreen(),
    Container(color : Colors.amberAccent,),
    Container(color : Colors.blueAccent,),
    Container(color : Colors.greenAccent,),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    if (size == null) {
      size = MediaQuery.of(context).size;
    }

    return Scaffold(
        key: _key,
        body: IndexedStack(
          index : _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar:  BottomNavigationBar(
          showSelectedLabels:  false,
          showUnselectedLabels:  false,
          items : btmNavItems,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black87,
          currentIndex: _selectedIndex,
          onTap: _onBtmItemClick,
        ),
    );
  }

  void _onBtmItemClick (int index) {
    switch(index) {
      case 2:
        _openCamera();
        break;
      default : {
        print(index);
        setState(() {
          _selectedIndex = index;
        });
      }
    }
  }

  Future _openCamera() async {
    if (await checkIfPermissionGranted(context))
    Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CameraScreen()));
    else {
      SnackBar snackBar = SnackBar(
        content : Text('사진 , 파일 , 마이크 접근 허용 해주셔야 카메라 사용 가능합니다.'),
        action : SnackBarAction(
          label : 'OK',
          onPressed: (){
            _key.currentState.hideCurrentSnackBar();
            AppSettings.openAppSettings();
          },
      )
      );
      _key.currentState.showSnackBar(snackBar);
    }
  }



  Future<bool> checkIfPermissionGranted(BuildContext context) async{
    Map<Permission, PermissionStatus> statuses = await [Permission.camera, Permission.microphone].request();
    bool permitted = true;

    statuses.forEach((permission, permissionStatus) {
      if(!permissionStatus.isGranted)
        permitted = false;
    });

    return permitted;
  }

}