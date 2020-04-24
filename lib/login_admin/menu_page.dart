import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recetapps/auth/auth.dart';
import 'package:recetapps/login_admin/contentPage.dart';
import 'package:recetapps/pages/admin/mostrargrid_page.dart';
import 'package:recetapps/widgets/home/home_page.dart';

const PrimaryColor = const Color(0xFF19212B);

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String usuario = 'Usuario';
  String usuarioEmail = 'Email';
  String id;

  Content Page = ContentPage();

  Widget contentPage = HomePageRecetas();

  void _signOut() async {
    try {
      widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.auth.infoUser().then((onValue) {
      setState(() {
        usuario = onValue.displayName;
        usuarioEmail = onValue.email;
        id = onValue.uid;
        print('ID DEL MENU $id');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 30.0,
        child: Container(
          color: Color(0xFF19212B),
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  maxRadius: 10.0,
                  backgroundImage: AssetImage('assets/img/cocina.jpg'),
                ),
                accountName: Text(
                  '$usuario', 
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                accountEmail: Text('$usuarioEmail',
                style: TextStyle(color: Colors.white)),
                decoration: BoxDecoration(
                  color: Color(0xDD262F3D),
                  image: DecorationImage(
                    alignment: Alignment(1.0, 0),
                    image: AssetImage(
                      'assets/img/misanplas.jpg',
                    ),
                    fit: BoxFit.scaleDown,
                  )
                ),
              ),

              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                  page.lista().then((value){
                    print(value);
                    setState(() {
                      contentPage = value;
                    });
                  });
                },
                leading: Icon(Icons.home, color: Color(0xFF4FC3F7)),
                title: Text('Home', style: TextStyle(color: Colors.white)),
              ),
              Divider(height: 2.0, color:Colors.white),
              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                  page.mireceta(id).then((value){
                    print(value);
                    setState(() {
                      contentPage = value;
                    });
                  });
                },
                leading: Icon(FontAwesomeIcons.pizzaSlice, color: Color(0xFF4FC3F7)),
                title: Text('Mi Receta', style: TextStyle(color: Colors.white)),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                  page.admin().then((value){
                    print(value);
                    setState(() {
                      contentPage = value;
                    });
                  });
                },
                leading: Icon(Icons.contact_mail, color: Color(0xFF4FC3F7)),
                title: Text('Admin', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                  page.mapa().then((value){
                    print(value);
                    setState(() {
                      contentPage = value;
                    });
                  });
                },
                leading: Icon(FontAwesomeIcons.map, color: Color(0xFF4FC3F7)),
                title: Text('Mapa Tiendas', style: TextStyle(color: Color(0xFF4FC3F7))),
          ),
          ListTile(
            title: Text('Salir', style: TextStyle(color: Color(0xFF4FC3F7))),
            leading: Icon(Icons.exit_to_app, color:Color(0xFF4FC3F7)),
            onTap: (){
              Navigator.of(context).pop();
              _signOut();
            },
          ),
          ],
        ),
      ),
    )
    appBar: AppBar(
      backgroundColor: PrimaryColor,
      title: Text('Recetas'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.grid_on),
          tooltip: 'Grid',
          onPressed: (){
            Route route = MaterialPageRoute(builder: (context) => GridPageInicio());
            Navigator.push(context, route);
          },
        )
      ],
    ),
    body: contentPage,
    );
  }
}
