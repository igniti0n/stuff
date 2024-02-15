class BrandAppBar extends StatefulWidget {
  const BrandAppBar({super.key, required this.title, this.trailing, this.leading});

  final String title;
  final Widget? leading;
  final Widget? trailing;

  @override
  State<BrandAppBar> createState() => _BrandAppBarState();
}

class _BrandAppBarState extends State<BrandAppBar> {
  double leadingWidth = 0.0;
  double titleWidth = 0.0;
  double trailingWidth = 0.0;
  bool addLeadingAndTrailingPaddingToTitle = false;

  void _calculateShouldAddPadding(double screenWidth) {
    const bufferWidth = 8;
    final availableWidth = screenWidth - leadingWidth - trailingWidth - bufferWidth;
    if (availableWidth < titleWidth) {
      addLeadingAndTrailingPaddingToTitle = true;
    } else {
      addLeadingAndTrailingPaddingToTitle = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return SizedBox(
        height: kToolbarHeight,
        child: Stack(
          children: [
            Row(
              children: [
                if (GoRouter.of(context).canPop())
                  MeasureSize(
                    onChange: (Size newSize) {
                      leadingWidth = newSize.width;
                      _calculateShouldAddPadding(screenWidth);
                    },
                    child: widget.leading ?? BackButton(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                const Spacer(),
                if (widget.trailing != null)
                  MeasureSize(
                    onChange: (Size newSize) {
                      trailingWidth = newSize.width;
                      _calculateShouldAddPadding(screenWidth);
                    },
                    child: widget.trailing!,
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (addLeadingAndTrailingPaddingToTitle) Gap(leadingWidth),
                Expanded(
                  child: Center(
                    child: MeasureSize(
                      onChange: (Size newSize) {
                        titleWidth = newSize.width;
                        _calculateShouldAddPadding(screenWidth);
                      },
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onPrimary,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                    ),
                  ),
                ),
                if (addLeadingAndTrailingPaddingToTitle) Gap(trailingWidth),
              ],
            ),
          ],
        ));
  }
}
