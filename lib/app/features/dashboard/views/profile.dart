import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nb_utils/nb_utils.dart';

class DTProfileScreen extends StatefulWidget {
  static String tag = '/DTProfileScreen';

  const DTProfileScreen();

  @override
  DTProfileScreenState createState() => DTProfileScreenState();
}

class DTProfileScreenState extends State<DTProfileScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future getData() async {
    return FirebaseFirestore.instance
        .collection('craftsman')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('craftsman')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            data['image'] == 'null'
                                ? data['gender'] == 'female'
                                    ? Image.asset('assets/images/woman.png',
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.cover)
                                        .cornerRadiusWithClipRRect(40)
                                    : Image.asset('assets/images/man.png',
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.cover)
                                        .cornerRadiusWithClipRRect(40)
                                : Image.network(data['image'],
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover)
                                    .cornerRadiusWithClipRRect(40),
                            16.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['name'], style: primaryTextStyle()),
                                2.height,
                                Text(data['email'], style: primaryTextStyle()),
                              ],
                            )
                          ],
                        ),
                        IconButton(
                          icon: const Icon(
                            AntDesign.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {},
                        ).visible(false)
                      ],
                    ).paddingAll(16);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            const Divider(height: 8).paddingOnly(top: 4, bottom: 4),
          ],
        ),
      ),
    );
  }
}
