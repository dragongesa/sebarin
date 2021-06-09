import 'package:flutter/material.dart';
import 'package:sebarin/constants/global_constants.dart';
import 'package:sebarin/constants/themes/dark_theme.dart';

class NavBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;

  const NavBar({Key? key, this.title, this.actions, this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ?? null,
      title: title != null
          ? Text(
              title!,
              style: TextStyle(color: primaryColor),
            )
          : Image.asset(
              GlobalConstants.appLogoPath,
              height: 30,
            ),
      elevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48);
}
