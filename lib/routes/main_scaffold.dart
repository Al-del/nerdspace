import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nerdspace/widgets/pages/bookmarks.dart';
import 'package:nerdspace/widgets/pages/feed.dart';
import 'package:nerdspace/widgets/image_bg_scaffold.dart';
import 'package:nerdspace/widgets/nerdspace_searchbar.dart';

import '../widgets/multipage_bg_transitioner.dart';
import '../widgets/nerdspace_bottombar.dart';

class MainScaffold extends StatefulWidget {
  MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final PageController _pageController = PageController();

  final animationDuration = Duration(milliseconds: 300);

  final int pageCount = 5;
  double pageValue = 0.0;

  int currentIndex = 0;

  final animationCurve = Curves.easeOut;

  final pageBackgrounds = [
    AssetImage('assets/fireplace-bg2k.jpg'),
    AssetImage('assets/bookshelf-bg2k.jpg'),
    AssetImage('assets/fireplace-bg2k.jpg'),
    AssetImage('assets/bookshelf-bg2k.jpg'),
    AssetImage('assets/fireplace-bg2k.jpg'),
  ];

  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page!.round() != currentIndex) {
        setState(() {
          currentIndex = _pageController.page!.round();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onBottomPageTap(int index) {
    setState(() {
      currentIndex = index;
    });

    _pageController.animateToPage(index,
        duration: animationDuration, curve: animationCurve);
  }

  @override
  Widget build(BuildContext context) {
    return ImageBgScaffold(
      image: MultipageBgTransitioner(
          pageController: _pageController,
          pageCount: pageCount,
          pageBackgrounds: pageBackgrounds),
      scaffold: Scaffold(
        body: PageView(
          controller: _pageController,
          children: const [
            Feed(),
            Bookmarks(),
            Bookmarks(),
            Bookmarks(),
            Bookmarks(),
          ],
        ),
        bottomNavigationBar: NerdspaceBottombar(
          selected: currentIndex,
          onTap: onBottomPageTap,
        ),
      ),
    );
  }
}
