import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recetapps/model/user_model.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signInEmailPassword(String email, String password);
  Future<String> signUpEmailPassword(Usuario usuario);
  Future<void> signOut();
  Future<String> currentUser();
  Future<FirebaseUser> infoUser();
}

class Auth implements BaseAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInEmailPassword(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user.uid; //devuelve el id del usuario
  }

  Future<String> signUpEmailPassword(Usuario usuarioModel) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
            email: usuarioModel.email, password: usuarioModel.password))
        .user;

    UserUpdateInfo usuario = UserUpdateInfo();
    usuario.displayName = usuarioModel.nombre;

    await user.updateProfile(usuario);
    await user
        .sendEmailVerification()
        .then((onValue) => print('Email de verificación envidado'))
        .catchError(
            (onError) => print('Error de Email de verificación: $onError'));

    await Firestore.instance
        .collection('usuarios')
        .document('${user.uid}')
        .setData({
          'nombre': usuarioModel.nombre,
          'telefono': usuarioModel.telefono,
          'email': usuarioModel.email,
          'ciudad': usuarioModel.ciudad,
          'direccion': usuarioModel.direccion
        })
        .then((value) => print('Usuario registrado en la Base de datos'))
        .catchError((onError) => print('Error al registrar el usuario'));
    return user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    String userId = user != null ? user.uid : 'no_login';
    return userId;
  }

  Future<FirebaseUser> infoUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    String userId = user != null ? user.uid : 'No se pudo recuperar el usuario';
    print('recuperando usuario + $userId');
    return user;
  }
}
