import 'package:doctorapp/data/firebase_service/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback show;
  const LoginScreen(this.show, {super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();
  @override
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
          SizedBox(height: 120.h),
          TextFild(email, Icons.email, 'Email', email_F),
          SizedBox(height: 15.h),
          TextFild(password, Icons.lock, 'Mot de passe', password_F),
          SizedBox(height: 10.h),
          Forgot(),
          SizedBox(height: 10.h),
          Login(),
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
              Text(
                "Vous n'avez pas de compte ?",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey,
                  )
                ),
              GestureDetector(
                onTap: widget.show,
                child: Text(
                "S'inscrire", style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold)
                ),
              )
            ],
          ),
        );
  }

  Widget Login() {
    return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.r),
          child: InkWell(
            onTap: () {
              Authentification().Login(email: email.text, password: password.text);
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 44.h,
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10.r)),
              child: Text(
                'Connexion',
                style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)  
              ),
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
