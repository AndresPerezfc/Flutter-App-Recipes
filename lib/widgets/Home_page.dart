import 'package:flutter/material.dart';
import 'package:recetapps/auth/auth.dart';

class HomePageRecetas extends StatefulWidget {
  @override
  _HomePageRecetasState createState() => _HomePageRecetasState();
}

class _HomePageRecetasState extends State<HomePageRecetas> {
  String userID;

  @override
  void initState() {
    super.initState();

    setState(() {
      Auth().currentUser().then((onValue) {
        userID = onValue;
        print('El futuro Cheft $userID');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Text(
              'Más buscado',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: FoodTop(),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Text(
              'Recetas Mundiales',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: FoodBody(),
        ),
      ],
    ));
  }
}
