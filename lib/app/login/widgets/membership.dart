import 'package:flutter/material.dart';

class Membership extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: <Widget>[
            const SizedBox(
              width: 90.0,
              child: Text(
                "Membership",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black),

              ),
            ),
            const SizedBox(
              width: 40.0,
            ),
            CircleAvatar(
              backgroundColor: Colors.blue[50],
              child: const Icon(Icons.account_balance_wallet),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const SizedBox(
              width: 50.0,
              child: Text(
                "Classic",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black),

              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.blue[50],
              child: const Icon(Icons.account_balance_wallet),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const SizedBox(
              width: 50.0,
              child: Text(
                "Silver",
                textAlign: TextAlign.left,
                style:  TextStyle(color: Colors.black),

              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            CircleAvatar(
              backgroundColor: Colors.blue[50],
              child: const Icon(Icons.account_balance_wallet),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const SizedBox(
              width: 90.0,
              child: Text(
                "Gold",
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
