import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CategoryLeftSide extends StatefulWidget {
  const CategoryLeftSide({Key? key}) : super(key: key);

  @override
  State<CategoryLeftSide> createState() => _CategoryLeftSideState();
}

class _CategoryLeftSideState extends State<CategoryLeftSide> {
  String defaultImageUrl =
      'https://cdn.pixabay.com/photo/2016/03/23/15/00/ice-cream-1274894_1280.jpg';
  String selctFile = '';
  XFile? file;
  Uint8List? selectedImageInBytes;
  List<Uint8List> pickedImagesInBytes = [];
  List<String> imageUrls = [];
  int imageCounts = 0;
  TextEditingController service = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController des = TextEditingController();
  String? supName;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Service",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                FutureBuilder(
                    future: getSupplier(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List sup = snapshot.data as List;
                        return SizedBox(
                          height: 60,
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                              searchFieldProps:
                                  TextFieldProps(cursorColor: Colors.black),
                              // disabledItemFn:
                              //     (String s) =>
                              //         s.startsWith('I'),
                            ),
                            items: List.generate(
                                sup.length, (index) => sup[index]['name']),
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              baseStyle: TextStyle(
                                color: Colors.black,
                              ),
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: "Enter category",
                                  hintStyle: TextStyle(color: Colors.black)),
                            ),
                            onChanged: (v) {
                              setState(() {
                                supName = v;
                                print(supName);
                              });
                            },
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
                const SizedBox(height: 12),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: service,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Empty data';
                    }
                  },
                  decoration: const InputDecoration(
                      label: Text(
                        "service Name",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      hintText: "Please write your service Name",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: price,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Empty data';
                    }
                  },
                  decoration: const InputDecoration(
                      label: Text(
                        "price",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      hintText: "Please write your service price",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  // Handles Form Validation
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length > 200) {
                      return 'Please describe service but keep it under 200 characters.';
                    }
                    return null;
                  },
                  controller: des,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    hintMaxLines: 3,
                    label: Text(
                      "Description",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    hintText: 'Description service',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                selctFile.isEmpty
                    ? Container()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.memory(
                          selectedImageInBytes!,
                          width: 150,
                          height: 150,
                        ),
                      ),
                MaterialButton(
                  onPressed: () {
                    selectFile(true);
                  },
                  height: 52,
                  elevation: 24,
                  color: const Color(0xFF03DAC5),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.image),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Pick Image"),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('craftsman')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        var data1 = snapshot.data;
                        return data1['accept']
                            ? MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    uploadFile();
                                  }
                                  Navigator.pop(context);
                                },
                                minWidth: double.infinity,
                                height: 52,
                                elevation: 24,
                                color: const Color(0xFF03DAC5),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32)),
                                child: const Text("Add"),
                              )
                            : Container();
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    ));
  }

  selectFile(bool imageFrom) async {
    FilePickerResult? fileResult =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (fileResult != null) {
      setState(() {
        selctFile = fileResult.files.first.name;
        selectedImageInBytes = fileResult.files.first.bytes;
      });

      fileResult.files.forEach((element) {
        setState(() {
          pickedImagesInBytes.add(element.bytes!);

          imageCounts += 1;
        });
      });
    }
    print(selctFile);
  }

  Future<String> uploadFile() async {
    String imageUrl = '';
    CollectionReference addPost = FirebaseFirestore.instance
        .collection('craftsman')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('services');
    try {
      firabase_storage.UploadTask uploadTask;

      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('services')
          .child('/$selctFile');

      final metadata =
          firabase_storage.SettableMetadata(contentType: 'image/jpeg');

      // uploadTask = ref.putFile(File(file!.path));
      uploadTask = ref.putData(selectedImageInBytes!, metadata);
      String docId2 =
          FirebaseFirestore.instance.collection('allService').doc().id;
      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      addPost.doc(docId2).set({
        'image': imageUrl,
        'isAccept': 0,
        "name": service.text,
        "des": des.text,
        'id': docId2,
        'type': supName!,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'price': price.text,
        'time': DateFormat('hh:mm a').format(DateTime.now()).toString(),
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
      });

      await FirebaseFirestore.instance
          .collection('craftsman')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('allService')
            .doc(docId2)
            .set({
          'image': imageUrl,
          'isAccept': 0,
          'id': docId2,
          "name": service.text,
          "des": des.text,
          'type': supName!,
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'craftsman': value['name'],
          'price': price.text,
          'time': DateFormat('hh:mm a').format(DateTime.now()).toString(),
          'date': DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        });
      });
    } catch (e) {
      print(e);
    }
    return imageUrl;
  }

  getSupplier() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("category").get();
    return qn.docs;
  }
}
