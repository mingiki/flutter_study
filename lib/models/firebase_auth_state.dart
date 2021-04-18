import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthState extends ChangeNotifier{
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _firebaseUser;

  void registerUser({@required String email, @required  String password})  {
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  void login ({@required String email, @required  String password})  {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  void watchAuthChange(){
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null && _firebaseUser == null) {
          return;
      } else if (_firebaseUser != _firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  void signOut(){
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_firebaseUser != null) {
      _firebaseUser = null;
      _firebaseAuth.signOut();
    }

    notifyListeners();
  }


  void changeFirebaseAuthStatus([FirebaseAuthStatus firebaseAuthStatus]){
    if(FirebaseAuthStatus != null){
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if (_firebaseAuthStatus != null){
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }

    notifyListeners();
  }


  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;



}

enum FirebaseAuthStatus{
  signout, progress, signin
}