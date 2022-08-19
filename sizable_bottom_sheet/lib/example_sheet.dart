import 'package:flutter/material.dart';
import 'package:sizable_bottom_sheet/sizable_bottom_sheet.dart';

class ExampleSheet extends StatelessWidget with ShowBottomSheet {
  const ExampleSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizableBottomSheet(
        content: Column(
      children: [
        const Text('An ecample sheet.'),
        const Icon(
          Icons.done_all,
          size: 64,
        ),
        const SizedBox(
          height: 400,
        ),
        Container(
          color: Colors.red,
          height: 400,
        ),
      ],
    ));
  }
}
