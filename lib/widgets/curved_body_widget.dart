import 'package:flutter/material.dart';

import '/constants/constants.dart';

class CurvedBodyWidget extends StatelessWidget {
  const CurvedBodyWidget({required this.widget, Key? key}) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
        color: Colors.white,
      ),
      padding: basePadding,
      child: widget,
    );
  }
}
