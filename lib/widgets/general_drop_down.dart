import 'package:flutter/material.dart';

class GeneralDropDown extends StatefulWidget {
  const GeneralDropDown({
    Key? key,
    required this.list,
    required this.method,
  }) : super(key: key);

  final Function method;

  final List list;

  @override
  State<GeneralDropDown> createState() => _GeneralDropDownState();
}

class _GeneralDropDownState extends State<GeneralDropDown> {
  final List<DropdownMenuItem<String>> list = [];

  String? selectedValue;

  @override
  void initState() {
    super.initState();

    for (var e in widget.list) {
      list.add(
        DropdownMenuItem(
          child: Text(e),
          value: e,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          isExpanded: true,
          items: list,
          onChanged: (value) {
            widget.method(
              context,
              widget.list.indexOf(value),
            );
            setState(() {
              selectedValue = value;
            });
          },
          hint: const Text("Seat"),
          value: selectedValue,
        ),
      ],
    );
  }
}
