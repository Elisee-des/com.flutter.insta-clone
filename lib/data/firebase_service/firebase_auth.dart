import 'dart:io';

import 'package:doctorapp/data/firebase_service/firestore.dart';
import 'package:doctorapp/data/firebase_service/storage.dart';
import 'package:doctorapp/util/exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentification {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> Login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } on FirebaseException catch (e) {
      throw exceptions(e.message.toString());
    }
  }
  
  Future<void> Signup({
    required String email,
    required String password,
    required String passwordConfirme,
    required String username,
    required String bio,
    required File profile,
  }) async {
    String URL;
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        if (password == passwordConfirme) {
          //Creation du compte avec l'email et le mot de passe
          await _auth.createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

          //Telecharge le proile image dans le storage
          if (profile != File('')) {
            URL = await StorageMethod().uploadImageStorage("Profile", profile);
          } else {
            URL = '';
          }

          await Firebase_Firestore().CreateUser(
              email: email,
              username: username,
              bio: bio,
              profile: URL == ''
                  ? 'https://firebasestorage.googleapis.com/v0/b/instagram-8a227.appspot.com/o/person.png?alt=media&token=c6fcbe9d-f502-4aa1-8b4b-ec37339e78ab'
                  : URL);
        } else {
          throw exceptions("Le mot de passe doit être identique !");
        }
      } else {
        throw exceptions("Tous les champs sont obligatoires!");
      }
    } on FirebaseException catch (e) {
      throw exceptions(e.message.toString());
    }
  }
}
