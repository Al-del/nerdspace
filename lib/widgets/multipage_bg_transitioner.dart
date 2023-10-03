import 'package:flutter/material.dart';

class MultipageBgTransitioner extends StatefulWidget {
  const MultipageBgTransitioner({
    super.key,
    required this.pageController,
    required this.pageBackgrounds,
    required this.pageCount,
  });

  final PageController pageController;
  final int pageCount;
  final List<AssetImage> pageBackgrounds;

  @override
  State<MultipageBgTransitioner> createState() =>
      _MultipageBgTransitionerState();
}

class _MultipageBgTransitionerState extends State<MultipageBgTransitioner> {
  double pageValue = 0.0;

  @override
  void initState() {
    widget.pageController.addListener(() {
      pageValue = widget.pageController.page ?? 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: widget.pageController,
        builder: (context, child) {
          if (pageValue == widget.pageCount) {
            return Image(
              image: widget.pageBackgrounds[pageValue.floor()],
            );
          }
          double fraction = pageValue - pageValue.floor();
          return Stack(
            children: [
              Center(
                child: Opacity(
                  opacity: 1 - fraction,
                  child: Image(
                    image: widget.pageBackgrounds[pageValue.floor()],
                  ),
                ),
              ),
              Center(
                child: Opacity(
                  opacity: fraction,
                  child: Image(
                    image: widget.pageBackgrounds[pageValue.ceil()],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
