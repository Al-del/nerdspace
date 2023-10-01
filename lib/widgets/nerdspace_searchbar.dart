import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NerdspaceSearchBar extends StatelessWidget {
  const NerdspaceSearchBar({super.key});
  final borderWidth = 5.0;
  final fieldPadding = 3.0;
  final hint = "Search by Title, Author or ISBN...";

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: hint,
        contentPadding: EdgeInsets.all(fieldPadding),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Colors.white,
            width: borderWidth,
          ),
        ),
      ),
    );
  }
}
