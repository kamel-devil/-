import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as dialog;

import '../../config/routes/app_pages.dart';
import '../widgets/gender.dart';
import '../widgets/input_field.dart';

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameCont = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  TextEditingController rePass = TextEditingController();

  TextEditingController naID = TextEditingController();

  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: const EdgeInsets.only(
            top: 60.0, bottom: 60.0, left: 120.0, right: 120.0),
        child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          elevation: 5.0,
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3.3,
                height: MediaQuery.of(context).size.height,
                color: const Color(0xff82abe3),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 70.0, right: 50.0, left: 50.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundColor: Colors.black87,
                          backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                          ),
                          radius: 70.0,
                        ),
                        const SizedBox(
                          height: 60.0,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: const Text(
                            "Let's get you set up",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: const Text(
                            "It should only take a couple of minutes to pair with your watch",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.black87,
                          child: Text(
                            ">",
                            style: TextStyle(color: Colors.yellow),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 40.0, right: 70.0, left: 70.0, bottom: 40.0),
                child: Column(
                  children: <Widget>[
                    //InputField Widget from the widgets folder
                    InputField(label: "Name", content: "Name", controller: nameCont,),

                    const SizedBox(height: 20.0),

                    //Gender Widget from the widgets folder
                    Gender(),

                    const SizedBox(height: 20.0),

                    //InputField Widget from the widgets folder
                    //InputField Widget from the widgets folder
                    InputField(label: "Email", content: "yo@seethat.com", controller: email,),

                    const SizedBox(height: 20.0),

                    InputField(label: "Mobile", content: "+22994684468", controller: phone,),

                    const SizedBox(height: 20.0),

                    //InputField Widget from the widgets folder
                    InputField(label: "National ID", content: "22223311111", controller: naID,),
                    const SizedBox(height: 20.0),

                    //InputField Widget from the widgets folder
                    InputField(label: "Password", content: "********", controller: pass,),
                    const SizedBox(height: 20.0),

                    //InputField Widget from the widgets folder
                    InputField(label: "Re-Enter Password", content: "********", controller: rePass,),
                    const SizedBox(
                      height: 40.0,
                    ),

                    //Membership Widget from the widgets folder

                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 170.0,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          // color: Colors.grey[200],
                          onPressed: () {
                            Get.toNamed(AppPages.initial);

                          },
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: () {

                            signUp().then((value) {
                              Get.toNamed(AppPages.initial);
                              addDataEmail();
                            });
                            // Get.lazyPut(() => DashboardController());
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    try {
      if (email.text.isNotEmpty &&
          pass.text.isNotEmpty &&
          nameCont.text.isNotEmpty &&
          naID.text.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: email.text, password: pass.text);
        return userCredential;
      } else {}
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        dialog.AwesomeDialog(
          context: context,
          dialogType: dialog.DialogType.info,
          animType: dialog.AnimType.bottomSlide,
          title: 'Attend  !',
          desc: 'The password is weak',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (e.code == 'email-already-in-use') {
        dialog.AwesomeDialog(
          context: context,
          dialogType: dialog.DialogType.info,
          animType: dialog.AnimType.bottomSlide,
          title: 'Attend  !',
          desc: 'This Account is Already Exist',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      print(e);
    }
  }

  addDataEmail() async {
    CollectionReference? addUser;
    User? user = FirebaseAuth.instance.currentUser;
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    addUser = FirebaseFirestore.instance.collection('craftsman');
    addUser?.doc('${user?.uid}').set({
      'email': email.text,
      'name': nameCont.text,
      'national_id': naID.text,
      'id': user?.uid,
      'image': 'null',
      'password': pass.text,
      'phone': phone.text,
      'created_at': time,
      'is_online': false,
      'last_active': time,
      'push_token': '',
      'about': 'Hallo'
    });
  }
}
