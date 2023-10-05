import 'package:flutter/material.dart';
import 'package:nerdspace/widgets/nerdspace_searchbar.dart';
import 'package:nerdspace/widgets/user_avatar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  final userAvatarExtent = 100.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NerdspaceSearchBar(),
          Text(
            "Last profiles seen:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints.loose(Size.fromHeight(userAvatarExtent)),
              child: Row(
                children: List.generate(
                  100,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UserAvatar(
                      visibleName: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            thickness: 3.0,
          ),
          Text(
            "Last queries:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            flex: 1,
            child: ListView(
              shrinkWrap: true,
              children: List.generate(
                100,
                (index) => Card(
                  child: ListTile(
                    title: Text("Query $index"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.exit_to_app_outlined,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
