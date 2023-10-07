import 'package:flutter/material.dart';
import 'package:nerdspace/routes/search_route.dart';
import 'package:nerdspace/widgets/nerdspace_searchbar.dart';
import 'package:nerdspace/widgets/user_avatar.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final subjects = [
    "fantasy",
    "fiction",
    "scifi",
    "drama",
    "romance",
    "nonfiction",
    "comedy",
    "ya",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(title: NerdspaceSearchBar()),
          Text(
            "Search by Subject:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            flex: 1,
            child: ListView(
                shrinkWrap: true,
                children: subjects
                    .map((e) => Card(
                          child: ListTile(
                            title: Text("$e"),
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/search',
                                    arguments:
                                        SearchRouteArguments("subject:$e"));
                              },
                              icon: Icon(
                                Icons.exit_to_app_outlined,
                              ),
                            ),
                          ),
                        ))
                    .toList()
                //  List.generate(
                //   100,
                //   (index) => Card(
                //     child: ListTile(
                //       title: Text("Query $index"),
                //       trailing: IconButton(
                //         onPressed: () {},
                //         icon: Icon(
                //           Icons.exit_to_app_outlined,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                ),
          )
        ],
      ),
    );
  }
}
