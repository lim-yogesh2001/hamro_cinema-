import 'package:flutter/material.dart';

class GeneralTableRow {
  TableRow buildTableSpacer(BuildContext context) {
    return const TableRow(
      children: [
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  TableRow buildTableDivider(BuildContext context) {
    return const TableRow(
      children: [
        Divider(
          thickness: 1,
        ),
        Divider(
          thickness: 1,
        ),
      ],
    );
  }

  TableRow buildTableRow(
    BuildContext context, {
    required String title,
    double? amount,
    String? month,
    bool isAmount = true,
  }) {
    return TableRow(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 14,
              ),
        ),
        Text(
          isAmount ? "Rs. $amount" : month!,
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 14,
              ),
        ),
      ],
    );
  }
}
