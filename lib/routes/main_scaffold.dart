import 'package:flutter/material.dart';
import 'package:nerdspace/widgets/feed.dart';
import 'package:nerdspace/widgets/image_bg_scaffold.dart';
import 'package:nerdspace/widgets/nerdspace_searchbar.dart';

import '../widgets/nerdspace_bottombar.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageBgScaffold(
      image: AssetImage('assets/fireplace bg.jpg'),
      scaffold: Scaffold(
        appBar: AppBar(
          title: NerdspaceSearchBar(),
        ),
        body: Feed(),
        bottomNavigationBar: NerdspaceBottombar(),
      ),
    );
  }
}
