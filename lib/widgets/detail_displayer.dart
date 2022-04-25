import 'package:flutter/material.dart';

class DetailDisplayer extends StatelessWidget {
  const DetailDisplayer({
    Key? key,
    required this.title,
    required this.value,
    this.isLastElement = false,
  }) : super(key: key);

  final String title;
  final String value;
  final bool isLastElement;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        if (!isLastElement)
          const SizedBox(
            height: 8,
          ),
      ],
    );
  }
}
