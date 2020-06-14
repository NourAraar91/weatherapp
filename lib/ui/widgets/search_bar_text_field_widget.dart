import 'package:flutter/material.dart';
import 'package:weatherapp/ui/styles/colors.dart';

class SearchBarTextField extends StatelessWidget {
  const SearchBarTextField({
    Key key,
    this.controller,
    this.focusNode,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function() onTap;
  final Function(String) onChanged;
  final Function() onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[shadow]),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: TextInputAction.search,
        onTap: onTap,
        keyboardType: TextInputType.text,
        enableSuggestions: false,
        autocorrect: false,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
            icon: Icon(
              Icons.search,
              color: darkGrayColor,
            ),
            hintText: 'Search',
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none),
      ),
    );
  }
}
