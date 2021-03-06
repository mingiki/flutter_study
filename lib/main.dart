import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two/constants/material_white89.dart';
import 'package:instagram_two/home_page.dart';
import 'package:instagram_two/models/firebase_auth_state.dart';
import 'package:instagram_two/screens/auth_screen.dart';
import 'package:instagram_two/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  Widget _currentWidget;

  //widget 이 처음 실행하는게 아래 build이다.
  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthChange();
    return ChangeNotifierProvider<FirebaseAuthState>.value(
      value: _firebaseAuthState,
      child: MaterialApp(
        home : Consumer<FirebaseAuthState>(builder: (BuildContext context,
            FirebaseAuthState firebaseAuthState, Widget child){

          switch(firebaseAuthState.firebaseAuthStatus){
            case FirebaseAuthStatus.signout:
              _currentWidget = AuthScreen();
              break;
            case FirebaseAuthStatus.signin:
              _currentWidget = HomePage();
              break;
            default:
              _currentWidget = MyProgressIndicator();

          }

          return AnimatedSwitcher(
              duration: Duration(milliseconds: 2000),
              child: _currentWidget,
          );

        }),
        theme: ThemeData(primarySwatch: white89)
      ),
    );
  }
}

