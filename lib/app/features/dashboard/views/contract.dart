import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ListOfRequested extends StatelessWidget {
  const ListOfRequested({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff131e29),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 640,
              width: 1180,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
              child: FutureBuilder(
                future: getServices(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List category = snapshot.data as List;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Contract",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19,
                                            color: Colors.black),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          icon: Icon(
                                            Icons.search,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          onPressed: () {}),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    children: List.generate(
                                      category.length,
                                      (index) => Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        child: ListTile(
                                          onTap: () {
                                            Get.defaultDialog(
                                                title: 'Contract',
                                                content: Padding(
                                                  padding: const EdgeInsets.all(
                                                      80.0),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const Text(
                                                              'Client : ',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              category[index]
                                                                  ['user'],
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const Text(
                                                              'address : ',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              category[index]
                                                                  ['address'],
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const Text(
                                                              'services : ',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              category[index]
                                                                  ['services'],
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const Text(
                                                              'type : ',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              category[index]
                                                                  ['type'],
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const Text(
                                                              'Information : ',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              category[index]
                                                                  ['info'],
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const Text(
                                                              'time : ',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              category[index]
                                                                  ['date'],
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const Text(
                                                              'price : ',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              category[index]
                                                                  ['price'],
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const Text(
                                                              'hours : ',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              category[index]
                                                                  ['hours'],
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const Text(
                                                              'Total Price : ',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              '${double.parse(category[index]['price']) * double.parse(category[index]['hours'])}',
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const Text(
                                                              'payment : ',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            category[index][
                                                                        'cash'] ==
                                                                    0
                                                                ? const Text(
                                                                    'Paiement when recieving',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white),
                                                                  )
                                                                : const Text(
                                                                    'Payment by card',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        IconButton(
                                                            onPressed:
                                                                () {
                                                              launchUrl(Uri.parse('https://wa.me/${category[index]['phone']}'));
                                                            },
                                                            icon: const Icon(
                                                                Icons
                                                                    .phone)),
                                                        const SizedBox(
                                                          height: 100,
                                                        ),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            elevation: 0,
                                                            primary: Colors.red,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            showDialog<void>(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              // user must tap button!
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  // <-- SEE HERE
                                                                  title: const Text(
                                                                      'Cancel booking'),
                                                                  content:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        ListBody(
                                                                      children: const <
                                                                          Widget>[
                                                                        Text(
                                                                            'Are you sure want to cancel booking?'),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      child: const Text(
                                                                          'No'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                    TextButton(
                                                                      child: const Text(
                                                                          'Yes'),
                                                                      onPressed:
                                                                          () async {
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection('craftsman')
                                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                                            .collection('requests')
                                                                            .doc(category[index]['id'])
                                                                            .set(
                                                                          {
                                                                            'isAccept':
                                                                                2,
                                                                          },
                                                                          SetOptions(
                                                                              merge: true),
                                                                        );
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection('users')
                                                                            .doc(category[index]['userUid'])
                                                                            .collection('request')
                                                                            .doc(category[index]['userDocID'])
                                                                            .set(
                                                                          {
                                                                            'isAccept':
                                                                                2,
                                                                          },
                                                                          SetOptions(
                                                                              merge: true),
                                                                        );
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                'craftsman')
                                                                            .doc(FirebaseAuth
                                                                                .instance.currentUser!.uid)
                                                                            .get()
                                                                            .then(
                                                                                (value) {
                                                                          FirebaseFirestore
                                                                              .instance
                                                                              .collection('craftsman')
                                                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                                                              .set(
                                                                            {
                                                                              'count': value['count'] + 1,
                                                                            },
                                                                            SetOptions(merge: true),
                                                                          );
                                                                        }).whenComplete(() =>
                                                                                Navigator.pop(context));
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection("craftsman")
                                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                                            .collection('requests')
                                                                            .doc(category[index]['id'])
                                                                            .delete();
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: const Text(
                                                            'Cancel Order',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                          },
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  category[index]['services'],
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  category[index]['info'],
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  category[index]['image'],
                                                ),
                                              ),
                                            ),
                                          ),
                                          trailing: Column(
                                            children: [
                                              Text(
                                                category[index]['date']
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              category[index]['isAccept'] == 0
                                                  ? const Text(
                                                      'Wait',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )
                                                  : category[index]
                                                              ['isAccept'] ==
                                                          1
                                                      ? const Text(
                                                          'Accept',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green),
                                                        )
                                                      : const Text(
                                                          'Reject',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        )
                                            ],
                                          ),
                                          subtitle: const Text(''),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: const [
                              Icon(
                                Icons.feedback,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Herafy For All Requested",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ));
  }

  Future getServices() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("craftsman")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('requests')
        .get();
    return qn.docs;
  }
}
