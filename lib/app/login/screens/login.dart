
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

import '../../config/routes/app_pages.dart';
import 'register.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    const inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(10.0),
    );

    return FlutterLogin(
      logo: 'assets/logo.png',
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 400.0),
          child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Home()),
                );            },
              child: const Text('Register',style: TextStyle(color: Colors.blue,fontSize: 24),)),
        )

      ],

      onLogin: (lData) {
        login1(lData.name, lData.password, context: context);
        return null;
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
      },
      theme: LoginTheme(
        primaryColor: Colors.white,
        accentColor: Colors.black,
        errorColor: Colors.deepOrange,
        titleStyle: const TextStyle(
          color: Colors.blue,
          fontFamily: 'Quicksand',
          letterSpacing: 4,
        ),
        bodyStyle: const TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
        buttonStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
        cardTheme: CardTheme(
          color: Colors.blue,
          elevation: 5,
          margin: const EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
        ),
        textFieldStyle: const TextStyle(color: Colors.black),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.purple.withOpacity(.1),
          contentPadding: EdgeInsets.zero,
          errorStyle: const TextStyle(
            backgroundColor: Colors.red,
            color: Colors.white,
          ),
          labelStyle: const TextStyle(fontSize: 12,color: Colors.white),

          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 4),
            borderRadius: inputBorder,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 5),
            borderRadius: inputBorder,
          ),
        ),
        buttonTheme: LoginButtonTheme(

          splashColor: Colors.purple,
          backgroundColor: Colors.white,
          highlightColor: Colors.lightGreen,
          elevation: 9.0,
          highlightElevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),


      ),
      onRecoverPassword: (email) {
        resetPassword(email);
      },
    );
  }
  Future login1(String email, pass, {context}) async {
    print(email);
    print(pass);
    try {
      if (email.isNotEmpty && pass.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass);
        // print(userCredential);
        Get.toNamed(AppPages.initial);
        return userCredential;
      } else {
        print('isEmpty');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.bottomSlide,
          title: 'Attend  !',
          desc: 'This Account IsNot Exist',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (e.code == 'wrong-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.bottomSlide,
          title: 'Attend  !',
          desc: 'The password is Wrong',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }
}
