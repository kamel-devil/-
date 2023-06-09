import 'package:flutter/material.dart';
import 'package:project_management/app/constans/app_constants.dart';

class UpgradePremiumCard extends StatelessWidget {
  const UpgradePremiumCard({
    required this.onPressed,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final Color? backgroundColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(kBorderRadius),
      color: backgroundColor ?? Theme.of(context).cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(kBorderRadius),
        onTap: onPressed,
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 150,
            maxWidth: 250,
            minHeight: 150,
            maxHeight: 250,
          ),
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 80,
                ),
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

