import 'package:flutter/material.dart';
import 'nerd_space.dart';
class NerdspaceSearchBar extends StatelessWidget {
  const NerdspaceSearchBar({super.key});
  final borderWidth = 5.0;
  final fieldPadding = 3.0;
  final hint = "Search by Title, Author or ISBN...";

  @override
  Widget build(BuildContext context) {
    return TextField(
       onSubmitted: (value) {
    // Handle the submitted value here
    sendMessage(value);
  },
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
