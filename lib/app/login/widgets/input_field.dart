import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final String content;
  TextInputType type;
  void Function(String)? onchange;
  String? Function(String?)? validat;
  TextEditingController controller = TextEditingController();
  InputField(
      {required this.label,
      required this.content,
      required this.controller,
      required this.type,
       this.onchange,
      required this.validat});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: <Widget>[
            SizedBox(
              width: 80.0,
              child: Text(
                label,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              width: 40.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3.7,
              color: Colors.blue[50],
              child: TextFormField(
                keyboardType: type,
                controller: controller,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue.shade50,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue.shade50,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: content,
                  hintStyle: const TextStyle(color: Colors.black38),
                  fillColor: Colors.blue[50],
                ),
                validator: validat,
                onChanged: onchange,
              ),
            ),
          ],
        );
      },
    );
  }
}
