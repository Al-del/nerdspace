import 'package:flutter/material.dart';

class NerdspaceBottombar extends StatelessWidget {
  const NerdspaceBottombar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.deepOrange,
              width: 3.0,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, -5),
              blurRadius: 20,
              spreadRadius: 10.0,
            )
          ]),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: "Bookmarks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: "Friends",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Me",
          ),
        ],
      ),
    );
  }
}
