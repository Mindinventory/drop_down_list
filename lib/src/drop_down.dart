import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDown {
  /// This gives the button text or it sets default text as 'click me'.
  final String? buttonText;

  /// This gives the bottom sheet title.
  final String? bottomSheetTitle;

  /// This will give the submit button text.
  final String? submitButtonText;

  /// This will give the submit button background color.
  final Color? submitButtonColor;

  /// This will give the hint to the search text filed.
  final String? searchHintText;

  /// This will give the background color to the search text filed.
  final Color? searchBackgroundColor;

  /// This will give the default search controller to the search text field.
  final TextEditingController? searchController;

  /// This will give the list of data.
  final List<SelectedListItem>? listOfData;

  /// This will give the call back to the multiple selected items from list.
  final Function(List<dynamic>)? callbackForMultipleSelectedItems;

  /// This will give the call back to the single selected item from list.
  final Function(String)? callbackForSelectedItem;

  /// This will give selection choise for single or multiple for list.
  final bool isSelectedMultiple;

  DropDown({
    Key? key,
    this.buttonText,
    this.bottomSheetTitle,
    this.submitButtonText,
    this.submitButtonColor,
    this.searchHintText,
    this.searchBackgroundColor,
    this.searchController,
    this.listOfData,
    this.callbackForMultipleSelectedItems,
    this.callbackForSelectedItem,
    required this.isSelectedMultiple,
  });
}

class DropDownState {
  DropDown dropDown;
  DropDownState(this.dropDown);

  /// This list will set when the list of data is not available.
  List<SelectedListItem> mainList = [];

  /// This is default search controller.
  final TextEditingController searchController = TextEditingController();

  /// This gives the bottom sheet widget.
  void showModal(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
              expand: false,
              builder: (BuildContext context, ScrollController scrollController) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// Bottom sheet title text
                          Text(
                            dropDown.bottomSheetTitle ?? 'Title',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          Expanded(
                            child: Container(),
                          ),

                          /// Submit button
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                                onPressed: () {
                                  List<SelectedListItem> selectedList = dropDown.listOfData!.where((element) => element.isSelected == true).toList();
                                  List<String> selectedNameList = [];

                                  for (var element in selectedList) {
                                    selectedNameList.add(element.name);
                                  }

                                  dropDown.callbackForMultipleSelectedItems?.call(selectedNameList);
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: dropDown.submitButtonColor ?? Colors.blue,
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: Text(dropDown.submitButtonText ?? 'Submit')),
                          ),
                        ],
                      ),
                    ),

                    /// A [TextField] that displays a list of suggestions as the user types with clear button.
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: dropDown.searchController ?? searchController,
                        cursorColor: Colors.black,
                        onChanged: (value) {
                          setState(() {
                            _buildSearchList(value);
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: dropDown.searchBackgroundColor ?? Colors.black12,
                          contentPadding: const EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 15),
                          hintText: dropDown.searchHintText ?? 'Search',
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          prefixIcon: const IconButton(
                            icon: Icon(Icons.search),
                            onPressed: null,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                dropDown.searchController!.clear();
                                mainList.clear();
                                searchController.clear();
                              });
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// Listview (list of data with check box for multiple selection & on tile tap single selection)
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: mainList.isNotEmpty ? mainList.length : dropDown.listOfData!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                child: ListTile(
                                  title: Text(
                                    mainList.isNotEmpty ? mainList[index].name : dropDown.listOfData![index].name,
                                  ),
                                  trailing: dropDown.isSelectedMultiple
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (mainList.isNotEmpty) {
                                                mainList[index].isSelected = !mainList[index].isSelected;
                                              } else {
                                                dropDown.listOfData![index].isSelected = !dropDown.listOfData![index].isSelected;
                                              }
                                            });
                                          },
                                          child: (mainList.isNotEmpty)
                                              ? mainList[index].isSelected
                                                  ? const Icon(Icons.check_box)
                                                  : const Icon(Icons.check_box_outline_blank)
                                              : dropDown.listOfData![index].isSelected
                                                  ? const Icon(Icons.check_box)
                                                  : const Icon(Icons.check_box_outline_blank),
                                        )
                                      : const SizedBox(
                                          height: 0.0,
                                          width: 0.0,
                                        ),
                                ),
                              ),
                            ),
                            onTap: dropDown.isSelectedMultiple
                                ? null
                                : () {
                                    dropDown.callbackForSelectedItem
                                        ?.call((mainList.isNotEmpty) ? mainList[index].name : dropDown.listOfData![index].name);
                                    Navigator.of(context).pop();
                                  },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  /// This helps when search enabled & show the filtered data in list.
  _buildSearchList(String userSearchTerm) {
    List<SelectedListItem> _searchList = [];

    for (int i = 0; i < dropDown.listOfData!.length; i++) {
      String name = dropDown.listOfData![i].name;
      if (name.toLowerCase().contains(userSearchTerm.toLowerCase())) {
        _searchList.add(dropDown.listOfData![i]);
      }
    }

    mainList = _searchList;
  }
}

/// This is Model class. Using this model class, you can add the list of data with title and its selection.
class SelectedListItem {
  bool isSelected;
  String name;

  SelectedListItem(this.isSelected, this.name);
}
