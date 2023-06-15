import 'package:awesome_dialog/awesome_dialog.dart' as dialog;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/app_pages.dart';
import '../widgets/input_field.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isMale = false;
  bool isFemale = false;
  String _errorMessage = '';

  String? gender;
  TextEditingController nameCont = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  TextEditingController rePass = TextEditingController();

  TextEditingController naID = TextEditingController();

  TextEditingController phone = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

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
                        const SizedBox(
                          height: 50.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 40.0, right: 70.0, left: 70.0, bottom: 40.0),
                  child: Form(
                    key: formGlobalKey,
                    child: Column(
                      children: <Widget>[
                        //InputField Widget from the widgets folder
                        InputField(
                          label: "Name",
                          content: "Name",
                          controller: nameCont,
                          validat: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Name';
                            }
                            return null;
                          },
                          type: TextInputType.text,
                        ),

                        const SizedBox(height: 20.0),

                        //Gender Widget from the widgets folder
                        LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 50,
                                  child: Text(
                                    "Gender",
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isMale = true;
                                      isFemale = false;
                                      gender = 'male';
                                    });
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue[50],
                                    child: Icon(Icons.face,
                                        color: isMale
                                            ? Colors.greenAccent
                                            : Colors.grey),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30.0,
                                ),
                                const SizedBox(
                                  width: 50.0,
                                  child: Text(
                                    "Male",
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isFemale = true;
                                      isMale = false;
                                      gender = 'female';
                                    });
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue[50],
                                    child: Icon(
                                      Icons.face,
                                      color: isFemale
                                          ? Colors.greenAccent
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30.0,
                                ),
                                const SizedBox(
                                  width: 100.0,
                                  child: Text(
                                    "Female",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20.0),
                        //InputField Widget from the widgets folder
                        //InputField Widget from the widgets folder
                        InputField(
                            label: "Email",
                            content: "yo@seethat.com",
                            controller: email,
                            onchange: (val) {
                              validateEmail(val);
                            },
                            type: TextInputType.emailAddress,
                            validat: (value) {
                              if (value!.isEmpty && !value.isEmail) {
                                return 'Please enter Email';
                              }
                              return null;
                            }),

                        const SizedBox(height: 20.0),

                        InputField(
                          label: "Mobile",
                          content: "+962784567456",
                          controller: phone,
                          type: TextInputType.phone,
                          validat: (val) {
                            if (!val!.startsWith("078") &&
                                !val.startsWith("077") &&
                                !val.startsWith("079")) {
                              return 'Invalid Phone Number ';
                            } else {
                              return null;
                            }
                          },
                        ),

                        const SizedBox(height: 20.0),

                        //InputField Widget from the widgets folder
                        InputField(
                          label: "National ID",
                          content: "2000553387",
                          controller: naID,
                          type: TextInputType.number,
                          validat: (val) {
                            if (val!.length != 10) {
                              return 'Invalid National ID';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),

                        //InputField Widget from the widgets folder
                        InputField(
                            label: "Password",
                            content: "********",
                            controller: pass,
                            type: TextInputType.text,
                            validat: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            }),
                        const SizedBox(height: 20.0),

                        //InputField Widget from the widgets folder
                        InputField(
                          label: "Re-Enter Password",
                          content: "********",
                          controller: rePass,
                          type: TextInputType.text,
                          validat: (val) {
                            if (val!.trim() != pass.text) {
                              return 'Error password';
                            } else {
                              return null;
                            }
                          },
                        ),
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
                                Get.to(const LoginScreen());
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
                                if (formGlobalKey.currentState!.validate()) {
                                  if (gender!.isNotEmpty) {
                                    formGlobalKey.currentState!.save();

                                    signUp().then((value) {
                                      Get.toNamed(AppPages.initial);
                                      addDataEmail();
                                    });
                                  }
                                }

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
      'accept': true,
      'name': nameCont.text,
      'national_id': naID.text,
      'id': user?.uid,
      'image': 'null',
      'gender': gender,
      'count': 0,
      'password': pass.text,
      'phone': phone.text,
      'created_at': time,
      'is_online': false,
      'last_active': time,
      'push_token': '',
      'about': 'Hallo'
    });
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }
}
