import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move_app_flutter/utils/theme_colors_ext.dart';

enum ContextMenuVisibility {
  onLongPress,
  onTap,
}

/// A widget that shows a context menu for a given [child].
class ContextMenu extends ConsumerWidget {
  final Widget child;
  final List<PopupMenuEntry<dynamic>> items;
  final Function(dynamic) onItemSelected;
  final ContextMenuVisibility visibility;
  final Color? splashColor;

  /// The key of the widget that the context menu is for.
  final GlobalKey widgetKey;

  /// The offset of the menu relative to the [child]. [Size] is the size of the [child].
  final Offset Function(Size)? menuOffset;
  const ContextMenu({
    super.key,
    required this.child,
    required this.widgetKey,
    required this.items,
    required this.onItemSelected,
    this.splashColor,
    this.menuOffset,
    this.visibility = ContextMenuVisibility.onLongPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: splashColor,
        radius: 80,
        onLongPress: () => visibility == ContextMenuVisibility.onLongPress ? _showMenu(context, ref) : null,
        onTap: () => visibility == ContextMenuVisibility.onTap ? _showMenu(context, ref) : null,
        child: child,
      ),
    );
  }

  void _showMenu(BuildContext context, WidgetRef ref) {
    final RenderBox renderBox = widgetKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx + (menuOffset?.call(renderBox.size).dx ?? 0),
        position.dy + (menuOffset?.call(renderBox.size).dy ?? 0),
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      items: items,
    ).then(onItemSelected);
  }
}

/// Custom context menu divider. Add it to the [ContextMenu.items] list to create a divider.
class ContextMenuDivider extends PopupMenuEntry<Never> {
  const ContextMenuDivider({super.key});

  @override
  final double height = 12;

  @override
  bool represents(void value) => false;

  @override
  State<ContextMenuDivider> createState() => _CustomPopupMenuDividerState();
}

class _CustomPopupMenuDividerState extends State<ContextMenuDivider> {
  @override
  Widget build(BuildContext context) => Divider(
        height: widget.height,
        color: context.customColors.onBackgroundGrey.withOpacity(0.5),
      );
}
