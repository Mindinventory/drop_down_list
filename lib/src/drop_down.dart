import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

import 'app_text_field.dart';

typedef SelectedItemsCallBack = Function(List<SelectedListItem> selectedItems);

typedef ListItemBuilder = Widget Function(int index);

typedef BottomSheetListener = bool Function(DraggableScrollableNotification draggableScrollableNotification);

class DropDown {
  /// This will give the list of data.
  final List<SelectedListItem> data;

  /// This will give the call back to the selected items from list.
  final SelectedItemsCallBack? selectedItems;

  /// [listItemBuilder] will gives [index] as a function parameter and you can return your own widget based on [index].
  final ListItemBuilder? listItemBuilder;

  /// This will give selection choice for single or multiple for list.
  final bool enableMultipleSelection;

  /// This gives the bottom sheet title.
  final Widget? bottomSheetTitle;

  /// You can set your custom submit button when the multiple selection is enabled.
  final Widget? submitButtonChild;

  /// [searchWidget] is use to show the text box for the searching.
  /// If you are passing your own widget then you must have to add [TextEditingController] for the [TextFormField].
  final TextFormField? searchWidget;

  /// [isSearchVisible] flag use to manage the search widget visibility
  /// by default it is [True] so widget will be visible.
  final bool isSearchVisible;

  /// This will set the background color to the dropdown.
  final Color dropDownBackgroundColor;

  /// [searchHintText] is use to show the hint text into the search widget.
  /// by default it is [Search] text.
  final String? searchHintText;

  /// [isDismissible] Specifies whether the bottom sheet will be dismissed when user taps on the scrim.
  /// If true, the bottom sheet will be dismissed when user taps on the scrim.
  /// by default it is [True].
  final bool isDismissible;

  /// [bottomSheetListener] that listens for BottomSheet bubbling up the tree.
  final BottomSheetListener? bottomSheetListener;

  DropDown({
    Key? key,
    required this.data,
    this.selectedItems,
    this.listItemBuilder,
    this.enableMultipleSelection = false,
    this.bottomSheetTitle,
    this.isDismissible = true,
    this.submitButtonChild,
    this.searchWidget,
    this.searchHintText = 'Search',
    this.isSearchVisible = true,
    this.dropDownBackgroundColor = Colors.transparent,
    this.bottomSheetListener,
  });
}

class DropDownState {
  DropDown dropDown;

  DropDownState(this.dropDown);

  /// This gives the bottom sheet widget.
  void showModal(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: dropDown.isDismissible,
      isDismissible: dropDown.isDismissible,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return MainBody(dropDown: dropDown);
          },
        );
      },
    );
  }
}

/// This is main class to display the bottom sheet body.
class MainBody extends StatefulWidget {
  final DropDown dropDown;

  const MainBody({required this.dropDown, Key? key}) : super(key: key);

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  /// This list will set when the list of data is not available.
  List<SelectedListItem> mainList = [];

  @override
  void initState() {
    super.initState();
    mainList = widget.dropDown.data;
    _setSearchWidgetListener();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: widget.dropDown.bottomSheetListener,
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.13,
        maxChildSize: 0.9,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Bottom sheet title text
                    Expanded(child: widget.dropDown.bottomSheetTitle ?? Container()),

                    /// Done button
                    Visibility(
                      visible: widget.dropDown.enableMultipleSelection,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Material(
                          child: ElevatedButton(
                            onPressed: () {
                              List<SelectedListItem> selectedList =
                                  widget.dropDown.data.where((element) => element.isSelected ?? false).toList();
                              List<SelectedListItem> selectedNameList = [];

                              for (var element in selectedList) {
                                selectedNameList.add(element);
                              }

                              widget.dropDown.selectedItems?.call(selectedNameList);
                              _onUnFocusKeyboardAndPop();
                            },
                            child: widget.dropDown.submitButtonChild ?? const Text('Done'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// A [TextField] that displays a list of suggestions as the user types with clear button.
              Visibility(
                visible: widget.dropDown.isSearchVisible,
                child: widget.dropDown.searchWidget ??
                    AppTextField(
                      dropDown: widget.dropDown,
                      onTextChanged: _buildSearchList,
                      searchHintText: widget.dropDown.searchHintText,
                    ),
              ),

              /// Listview (list of data with check box for multiple selection & on tile tap single selection)
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: mainList.length,
                  itemBuilder: (context, index) {
                    bool isSelected = mainList[index].isSelected ?? false;
                    return InkWell(
                      child: Container(
                        color: widget.dropDown.dropDownBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: ListTile(
                            title: widget.dropDown.listItemBuilder?.call(index) ??
                                Text(
                                  mainList[index].name,
                                ),
                            trailing: widget.dropDown.enableMultipleSelection
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        mainList[index].isSelected = !isSelected;
                                      });
                                    },
                                    child: isSelected
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
                      onTap: widget.dropDown.enableMultipleSelection
                          ? null
                          : () {
                              widget.dropDown.selectedItems?.call([mainList[index]]);
                              _onUnFocusKeyboardAndPop();
                            },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// This helps when search enabled & show the filtered data in list.
  _buildSearchList(String userSearchTerm) {
    final results = widget.dropDown.data
        .where((element) => element.name.toLowerCase().contains(userSearchTerm.toLowerCase()))
        .toList();
    if (userSearchTerm.isEmpty) {
      mainList = widget.dropDown.data;
    } else {
      mainList = results;
    }
    setState(() {});
  }

  /// This helps to UnFocus the keyboard & pop from the bottom sheet.
  _onUnFocusKeyboardAndPop() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  void _setSearchWidgetListener() {
    TextFormField? _searchField = widget.dropDown.searchWidget;
    _searchField?.controller?.addListener(() {
      _buildSearchList(_searchField.controller?.text ?? '');
    });
  }
}
