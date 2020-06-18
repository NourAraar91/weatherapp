import 'package:flutter/material.dart';
import 'package:weatherapp/ui/styles/app_bar_style.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  NavBar({
    this.titleWidget,
    this.title,
    this.centerTitle = true,
    this.titleStyle,
    this.backgroundColor,
    this.hideNavBar = false,
    this.showBackButton = false,
    this.backButtonColor,
    this.leading,
    this.actions,
  }) : preferredSize = const Size.fromHeight(60.0);

  final String title;
  final bool centerTitle;
  final TextStyle titleStyle;
  final Color backgroundColor;
  final bool hideNavBar;
  final bool showBackButton;
  final Color backButtonColor;
  final Widget leading;
  final List<Widget> actions;
  final Widget titleWidget;

  final AppBarStyle style = AppBarStyle();

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ??
          Text(
            title ?? '',
            style: titleStyle ?? style.titleStyle,
          ),
      centerTitle: centerTitle,
      backgroundColor: hideNavBar
          ? Colors.transparent
          : backgroundColor ?? style.backgroundColor,
      elevation: hideNavBar ? 0.0 : 1.0,
      leading: showBackButton
          ? BackButton(color: backButtonColor ?? style.backButtonColor)
          : leading,
      actions: actions,
    );
  }
}
