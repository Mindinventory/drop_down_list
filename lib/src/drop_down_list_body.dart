part of drop_down_list;

/// This is main class to display the bottom sheet body.
class MainBody extends StatefulWidget {
  final DropDownList dropDownList;

  const MainBody({required this.dropDownList, Key? key}) : super(key: key);

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  /// This list will set when the list of data is not available.
  List<SelectedListItem> mainList = [];

  @override
  void initState() {
    super.initState();
    mainList = widget.dropDownList.data;
    _setSearchWidgetListener();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
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
                  Expanded(child: widget.dropDownList.bottomSheetTitle ?? Container()),

                  /// Done button
                  Visibility(
                    visible: widget.dropDownList.enableMultipleSelection,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Material(
                        child: ElevatedButton(
                          onPressed: () {
                            List<SelectedListItem> selectedList =
                                widget.dropDownList.data.where((element) => element.isSelected == true).toList();
                            List<dynamic> selectedNameList = [];

                            for (var element in selectedList) {
                              selectedNameList.add(element);
                            }

                            widget.dropDownList.selectedItems?.call(selectedNameList);
                            _onUnFocusKeyboardAndPop();
                          },
                          child: widget.dropDownList.submitButtonChild ?? const Text('Done'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// A [TextField] that displays a list of suggestions as the user types with clear button.
            Visibility(
              child: widget.dropDownList.searchWidget ??
                  AppTextField(
                    onTextChanged: _buildSearchList,
                  ),
              visible: widget.dropDownList.isSearchVisible,
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
                      color: widget.dropDownList.dropDownBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: ListTile(
                          title: widget.dropDownList.listBuilder?.call(index) ??
                              Text(
                                mainList[index].name,
                              ),
                          trailing: widget.dropDownList.enableMultipleSelection
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
                    onTap: widget.dropDownList.enableMultipleSelection
                        ? null
                        : () {
                            widget.dropDownList.selectedItems?.call([mainList[index]]);
                            _onUnFocusKeyboardAndPop();
                          },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  /// This helps when search enabled & show the filtered data in list.
  _buildSearchList(String userSearchTerm) {
    final results = widget.dropDownList.data
        .where((element) => element.name.toLowerCase().contains(userSearchTerm.toLowerCase()))
        .toList();
    if (userSearchTerm.isEmpty) {
      mainList = widget.dropDownList.data;
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
    widget.dropDownList.searchWidget?.controller?.addListener(() {
      _buildSearchList(widget.dropDownList.searchWidget?.controller?.text ?? '');
    });
  }
}
