import 'package:flutter/material.dart';
import 'text_widget.dart';

/// 🧭 [CustomAppBar] — reusable app bar with flexible title, actions and leading icon support
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final List<IconData>? actionIcons;
  final List<VoidCallback>? actionCallbacks;
  final List<Widget>? actionWidgets;
  final bool isCenteredTitle;
  final bool isNeedPaddingAfterActionIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actionIcons,
    this.actionCallbacks,
    this.actionWidgets,
    this.isCenteredTitle = false,
    this.isNeedPaddingAfterActionIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    // 🧪 Runtime check for consistency between icons and callbacks
    if (actionWidgets == null &&
        (actionIcons?.length != actionCallbacks?.length)) {
      throw FlutterError(
        '❗️[CustomAppBar] → actionIcons and actionCallbacks must have the same length if actionWidgets is null.',
      );
    }

    return AppBar(
      centerTitle: isCenteredTitle,

      /// 🧾 Title styled via [TextWidget]
      title: TextWidget(
        title,
        TextType.titleMedium,
        alignment: isCenteredTitle ? TextAlign.center : TextAlign.start,
      ),

      /// 🔙 Optional back or menu icon
      leading: leadingIcon != null
          ? IconButton(
              icon: Icon(leadingIcon),
              onPressed: onLeadingPressed,
            )
          : null,

      /// 🎯 Actions - either custom widgets or icon-button pairs
      actions: actionWidgets ??
          [
            if (actionIcons != null && actionCallbacks != null)
              for (int i = 0; i < actionIcons!.length; i++)
                IconButton(
                  icon: Icon(actionIcons![i]),
                  onPressed: actionCallbacks![i],
                ),

            // ➕ Optional spacing after icons for visual polish
            if ((actionIcons?.isNotEmpty ?? false) &&
                isNeedPaddingAfterActionIcon)
              const SizedBox(width: 18),
          ],
    );
  }

  /// 🧱 AppBar height (kToolbarHeight = 56)
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}