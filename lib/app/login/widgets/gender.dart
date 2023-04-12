import 'package:flutter/material.dart';

class Gender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: <Widget>[
            const SizedBox(
              width: 80.0,
              child: Text(
                "Gender",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black),

              ),
            ),
            const SizedBox(
              width: 40.0,
            ),
            CircleAvatar(
              backgroundColor: Colors.blue[50],
              child: const Icon(Icons.face, color: Colors.grey),
            ),
            const SizedBox(
              width: 30.0,
            ),
            const SizedBox(
              width: 70.0,
              child: Text(
                "Male",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black),

              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.blue[50],
              child: const Icon(
                Icons.face,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              width: 30.0,
            ),
            const SizedBox(
              width: 140.0,
              child: Text(
                "Female",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black),

              ),
            ),
          ],
        );
      },
    );
  }
}
