import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:nerdspace/nerdfire.dart';
import 'package:nerdspace/widgets/book_card_grid_item.dart';

class AddActivityBottomSheet extends StatefulWidget {
  final BookData data;
  AddActivityBottomSheet({super.key, required this.data});

  @override
  State<AddActivityBottomSheet> createState() => _AddActivityBottomSheetState();
}

class _AddActivityBottomSheetState extends State<AddActivityBottomSheet> {
  final bookStatusOptions = ["Reading", "Completed", "Dropped"];

  String selectedBookStatus = "Reading";

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Add to bookmarks", style: textTheme.titleLarge),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Current Page:"),
                ),
              ),
              Expanded(
                child: SpinBox(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Set Status:"),
                ),
              ),
              Expanded(
                child: DropdownButton(
                  value: selectedBookStatus,
                  onChanged: (element) {
                    setState(() {
                      selectedBookStatus = element ?? selectedBookStatus;
                    });
                  },
                  items: bookStatusOptions
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await NerdFire().addBookData(
                      numberofPages: 666, bookData: widget.data, status: "WHA");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Posted succesfully! Check your bookmarks.")));
                  Navigator.pop(context);
                },
                child: Text("Done"),
              )
            ],
          )
        ],
      ),
    );
  }
}
