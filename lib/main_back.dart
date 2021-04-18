import 'package:flutter/material.dart';
import 'package:instagram_two/constants/material_white89.dart';
import 'package:instagram_two/home_page.dart';
import 'package:instagram_two/models/firebase_auth_state.dart';
import 'package:instagram_two/screens/auth_screen.dart';
import 'package:instagram_two/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  
  //widget 이 처음 실행하는게 아래 build이다.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirebaseAuthState>.value(
      value: _firebaseAuthState,
      child: MaterialApp(
        home : Consumer<FirebaseAuthState>(builder: (BuildContext context,
            FirebaseAuthState firebaseAuthState, Widget child){
            switch(firebaseAuthState.firebaseAuthStatus){
              case FirebaseAuthStatus.signout:
                return AuthScreen();
              case FirebaseAuthStatus.progress:
               return MyProgressIndicator();
              case FirebaseAuthStatus.signin:
               return HomePage();
              default:
                return MyProgressIndicator();
            }
          },
        child: HomePage()),
        theme: ThemeData(
          primarySwatch: white89
        ),
      ),
    );
  }
}

