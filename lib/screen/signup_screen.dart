import 'dart:io';

import 'package:doctorapp/data/firebase_service/firebase_auth.dart';
import 'package:doctorapp/util/dialog.dart';
import 'package:doctorapp/util/exception.dart';
import 'package:doctorapp/util/imagepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback show;
  const SignupScreen(this.show, {super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();
  final bio = TextEditingController();
  FocusNode bio_F = FocusNode();
  final username = TextEditingController();
  FocusNode username_F = FocusNode();
  final passwordConfirme = TextEditingController();
  FocusNode passwordConfirme_F = FocusNode();
  File? _imageFile;

  @override
    void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
    passwordConfirme.dispose();
    username.dispose();
    bio.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 96.w,
            height: 100.h,
          ),
          Center(
            child: Image.asset('images/logo.jpg'),
          ),
          SizedBox(height: 20.h),
          Center(
            child: InkWell(
              onTap: () async {
              File _imagefilee = await ImagePickerr().uploadImage('gallery');
              setState(() {
                _imageFile = _imagefilee;
              });
            },
              child: CircleAvatar(
                radius: 40.r,
                backgroundColor: Colors.grey.shade200,
                child: CircleAvatar(
                radius: 40.r,
                backgroundColor: Colors.grey,
                child: _imageFile == null
                    ? CircleAvatar(
                        radius: 40.r,
                        backgroundImage: const AssetImage('images/person.png'),
                        backgroundColor: Colors.grey.shade200,
                      )
                    : CircleAvatar(
                        radius: 40.r,
                        backgroundImage: Image.file(
                          _imageFile!,
                          fit: BoxFit.cover,
                        ).image,
                        backgroundColor: Colors.grey.shade200,
                      ),
              ),
              ),
            )),
          SizedBox(height: 50.h),
          TextFild(email, Icons.email, 'Email', email_F),
          SizedBox(height: 15.h),
          TextFild(username, Icons.person, 'Nom complet', username_F),
          SizedBox(height: 15.h),
          TextFild(bio, Icons.abc, 'Bio', bio_F),
          SizedBox(height: 15.h),
          TextFild(password, Icons.lock, 'Mot de passe', password_F),
          SizedBox(height: 10.h),
          TextFild(passwordConfirme, Icons.lock, 'Repetez le mot de passe',
              passwordConfirme_F),
          SizedBox(height: 20.h),
          Signup(),
          SizedBox(height: 10.h),
          Have()
        ],
      )),
    );
  }

  Widget Have() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Vous n'avez pas de compte ?",
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey,
              )),
          GestureDetector(
            onTap: widget.show,
            child: Text("Se connecter",
                style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget Signup() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.r),
      child: InkWell(
        onTap:  () async {
          try {
            await Authentification().Signup(email: email.text, password: password.text, passwordConfirme: passwordConfirme.text, username: username.text, bio: bio.text, profile:File(''));
          } on exceptions catch (e) {
            dialogBuilder(context, e.message);
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 44.h,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(10.r)),
          child: Text("S'inscrire",
              style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Padding Forgot() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Text('Mot de passe oublié ?',
          style: TextStyle(
              fontSize: 13.sp,
              color: Colors.blue,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget TextFild(TextEditingController controller, IconData icon, String type,
      FocusNode focusNode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: TextField(
          style: const TextStyle(fontSize: 18, color: Colors.black),
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: type,
            prefixIcon: Icon(icon,
                color: focusNode.hasFocus ? Colors.black : Colors.grey),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.grey, width: 2.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.blue, width: 2.w),
            ),
          ),
        ),
      ),
    );
  }
}
