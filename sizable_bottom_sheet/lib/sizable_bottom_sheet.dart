// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SizableBottomSheet extends StatelessWidget {
  final Widget content;
  final Widget header;
  final double? maximumSheetHeigh;
  final bool isScrollable;

  /// Shows a [content] as a modal bottom sheet, with an optional [header] that is
  /// displayed on the very top of the bottom sheet. If the content is big enough
  /// to require scrolling, the header serves as a "catch" to enable the shrinking of the sheet.
  ///
  ///  The height of the sheet is determined by the height of the content, but the maximum of the height is
  /// clamped to the [maximumSheetHeight], or by default 90% of the height of the screen, to allow the background to be visible.
  const SizableBottomSheet({
    super.key,
    required this.content,
    this.maximumSheetHeigh,
    this.isScrollable = true,
    this.header = const SizedBox(
      height: 40,
    ),
  });

  @override
  Widget build(BuildContext context) {
    final maximumModalSheetHeight =
        maximumSheetHeigh ?? MediaQuery.of(context).size.height * 0.9;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maximumModalSheetHeight,
      ),
      child: IntrinsicHeight(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                header,
                Expanded(
                  child: SingleChildScrollView(
                    physics: isScrollable
                        ? null
                        : const NeverScrollableScrollPhysics(),
                    child: content,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

mixin ShowBottomSheet on StatelessWidget {
  void show(
    BuildContext context, {
    bool isDismissable = true,
    bool isBackgroundTransperent = false,
  }) =>
      showModalBottomSheet(
        isDismissible: isDismissable,
        backgroundColor: Colors.transparent,
        barrierColor: isBackgroundTransperent ? Colors.transparent : null,
        isScrollControlled: true,
        context: context,
        builder: (context) => this,
      );
}

// For using with riverpod
// mixin ShowConsumerBottomSheet on ConsumerWidget {}
