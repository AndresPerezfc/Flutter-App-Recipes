import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recetapps/auth/auth.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus {
  notSignIn,
  signIn
} //sirve para saber el estatus del usuario, logueado o no

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((onValue) {
      setState(() {
        print(onValue);
        _authStatus =
            onValue == 'no_login' ? AuthStatus.notSignIn : AuthStatus.signIn;
      });
    });
  }

  void _signIn() {
    setState(() {
      _authStatus = AuthStatus.signIn;
    });
  }

  void _signOut() {
    setState(() {
      _authStatus = AuthStatus.notSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _widget;

    //si el usuario ya esta logueado la app lo enviara al homePage y si no el login y registro

    switch (_authStatus) {
      case AuthStatus.notSignIn:
        return IntroScreen(
          auth: widget.auth,
          onSignIn: _signIn,
        );
        break;
      case AuthStatus.signIn:
        return HomePage(
          auth: widget.auth,
          onSignedOut: _signOut,
        );
        break;
    }
    return _widget;
  }
}
