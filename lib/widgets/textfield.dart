import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String? hintText;
  final Function(String value)? onChanged;
  final IconData? icon;
  const CustomTextfield(
      {this.hintText, this.onChanged, this.icon = Icons.search});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onChanged: onChanged,
        cursorColor: Theme.of(context).primaryColor,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.black26,
          ),
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
