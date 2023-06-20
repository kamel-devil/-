import 'package:flutter/material.dart';

import 'componentof service/left_side.dart';
import 'componentof service/right_side.dart';

class Service extends StatelessWidget {
  const Service({Key? key}) : super(key: key);

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
            width: 1080,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
            ),
            child: Row(
              children: [
                const CategoryLeftSide(),
                if (MediaQuery.of(context).size.width > 900)
                  const CategoryRightSide(),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
