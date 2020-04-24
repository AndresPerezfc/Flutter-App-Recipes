import 'package:flutter/material.dart';

import 'package:recetapps/auth/auth.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({this.auth, this.onSignIn});
  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

enum AuthStatus {notSignIn, signIn}

class _IntroScreenState extends State<IntroScreen> {

  AuthStatus _authStatus = AuthStatus.notSignIn;

  List<Slide> slides = new List();

  @override
  void.@override
  void initState() {
    // TODO: implement initState
    super.initState();
      widget.auth.currentUser().then((onValue){
        setState(() {
          print(onValue);
          _authStatus = onValue == 'no_login' ? AuthStatus.notSignIn : AuthStatus.signIn;
        });
      });

    slides.add(
      new Slide(
        title: 'Ingredientes',
        maxLineTitle: 2,
        styleTitle: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description: 'Crea tus propias recetas',
        styleDescription: TextStyle(color: Colors.black, fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Relaway'),
        marginDescription: EdgeInsets.only(left: 20.0, right: 20.0, top:20.0, bottom: 70.0),
        centerWidget: Text('Deslice para pasar a la siguiente pantalla', style: TextStyle(color: Colors.black)),
        backgroundImage: 'assets/img/comida.png',
        onCenterItemPress: (){}
      )
    );

    slides.add(
      new Slide(
        title: 'Recetas Mundiales',
        styleTitle: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description: 'Conoce sobre toda la comida del mundo',
        styleDescription: TextStyle(color: Colors.black, fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Relaway'),
        backgroundImage: 'assets/img/comida.png',
      )
    );

    slides.add(
      new Slide(
        title: 'Ingredientes',
        maxLineTitle: 2,
        styleTitle: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description: 'Crea tus propias recetas',
        styleDescription: TextStyle(color: Colors.black, fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Relaway'),
        marginDescription: EdgeInsets.only(left: 20.0, right: 20.0, top:20.0, bottom: 70.0),
        centerWidget: Text('Deslice para pasar a la siguiente pantalla', style: TextStyle(color: Colors.black)),
        backgroundImage: 'assets/img/recet.png',
        onCenterItemPress: (){}
      )
    );

    slides.add(
      new Slide(
        title: "Receta pizza italiana",
        styleTitle:
            TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description:
            "Ordena todo antes de iniciar la preparacion, vamos adelante...",
        styleDescription:
            TextStyle(color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Raleway'),
        backgroundImage: 'assets/img/comida.png',       
        maxLineTextDescription: 3,
      ),
    );
  }

  void onDonePress(){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => LoginPage(auth: widget.auth, onSignIn: widget.onSignIn)));
  }

  Widget renderNextBtn(){
    return Icon(
    Icons.navigate_next,
    color: Colors.white,
    size: 35.0);
  }

  Widget renderDoneBtn(){
    return Icon(
    Icons.done,
    color: Colors.white)
  }

  Widget renderSkipBtn(){
    return Icon(
    Icons.skip_next,
    color: Colors.white);
  }




  @override
  Widget build(BuildContext context) {
    return IntroSlider(

      //lista de slides
      slides: this.slides,

      //Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Colors.orangeAccent,
      highlightColorSkipBtn: Color(0xff000000),

      //next Button
      renderNextBtn: this.renderNextBtn(),

      //done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Colors.blueAccent,
      highlightColorDoneBtn: Color(0xff69303),

      //dot indicator
      colorDot: Colors.white,
      colorActiveDot: Colors.orangeAccent[200],
      sizeDot: 13.0,

      //show or hide status bar
      shouldHideStatusBar: true,
      backgroundColorAllSlides: Colors.blueGrey,
    );
  }
}
