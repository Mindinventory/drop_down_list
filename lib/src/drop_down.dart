import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

import 'search_text_field.dart';

/// A callback function that is invoked when items are selected
typedef ItemSelectionCallBack<T> = void Function(
  List<SelectedListItem<T>> selectedItems,
);

/// A function type definition for building a widget for a specific list item
typedef ListItemBuilder<T> = Widget Function(
  int index,
  SelectedListItem<T> dataItem,
);

/// A function type definition for searching through a list of items based on the user's query
typedef SearchDelegate<T> = List<SelectedListItem<T>> Function(
  String query,
  List<SelectedListItem<T>> dataItems,
);

/// A function type definition for handling notifications from a draggable bottom sheet
typedef BottomSheetListener = bool Function(
  DraggableScrollableNotification draggableScrollableNotification,
);

/// A generic and customizable dropdown widget with support for single and multiple selections,
/// a searchable list, and advanced configuration options
///
/// The `DropDown` widget provides a flexible way to display a list of items
/// in a bottom sheet with optional features such as search, select all, and
/// multiple selection
class DropDown<T> {
  /// The list of generic data items to be displayed in the dropdown
  final List<SelectedListItem<T>> data;

  /// A callback function triggered when items are selected from the list
  final ItemSelectionCallBack<T>? onSelected;

  /// A function that takes an [index] and [dataItem] as a parameter and returns a custom widget
  /// to display for the list item at that index
  final ListItemBuilder<T>? listItemBuilder;

  /// Enables single or multiple selection for the drop down list items
  /// Set to `true` to allow multiple items to be selected at once
  ///
  /// Default Value: [false]
  final bool enableMultipleSelection;

  /// The maximum number of items that can be selected when [enableMultipleSelection] is true
  final int? maxSelectedItems;

  /// A callback function triggered when the maximum selection limit is reached
  ///
  /// This callback is called when the number of selected items exceeds or reaches
  /// the value specified by [maxSelectedItems]
  final VoidCallback? onMaxSelectionReached;

  /// The padding applied to the `ListView` that contains the dropdown items
  ///
  /// If not provided (i.e., null), [EdgeInsets.zero] will be applied
  final EdgeInsets? listViewPadding;

  /// The widget used as a separator between items in the dropdown list
  ///
  /// This can be any widget, such as a `Divider` or `SizedBox`
  ///
  /// If not provided (i.e., null), a default `Divider` with a color of
  /// [Colors.black12] and a height of 0 will be applied
  final Widget? listViewSeparatorWidget;

  /// The padding applied to the content of each `ListTile` in the dropdown list
  ///
  /// If not provided (i.e., null), the default padding of
  /// [EdgeInsets.symmetric(horizontal: 20)] will be applied
  final EdgeInsets? listTileContentPadding;

  /// Defines the background color of each `ListTile` in the dropdown list
  /// Default Value: [Colors.transparent]
  final Color listTileColor;

  /// The widget displayed as a trailing icon when a list item is selected
  ///
  /// This is used only when [enableMultipleSelection] is true
  ///
  /// Default Value: [Icon(Icons.check_box)]
  final Widget selectedListTileTrailingWidget;

  /// The widget displayed as a trailing icon when a list item is not selected
  ///
  /// This is used only when [enableMultipleSelection] is true
  ///
  /// Default Value: [Icon(Icons.check_box_outline_blank)]
  final Widget deSelectedListTileTrailingWidget;

  /// Specifies whether a modal bottom sheet should be displayed using the root navigator
  ///
  /// Default Value: [false]
  final bool useRootNavigator;

  /// Specifies whether the bottom sheet can be dragged up and down and dismissed by swiping downwards
  ///
  /// Default Value: [true]
  final bool enableDrag;

  /// Specifies whether the bottom sheet will be dismissed when the user taps on the scrim
  ///
  /// Default Value: [true]
  final bool isDismissible;

  /// The initial fractional value of the parent container's height to use when
  /// displaying the [DropDown] widget in [DraggableScrollableSheet]
  ///
  /// Default Value: [0.7]
  final double initialChildSize;

  /// The minimum fractional value of the parent container's height to use when
  /// displaying the [DropDown] widget in [DraggableScrollableSheet]
  ///
  /// Default Value: [0.3]
  final double minChildSize;

  /// The maximum fractional value of the parent container's height to use when
  /// displaying the [DropDown] widget in [DraggableScrollableSheet]
  ///
  /// Default Value: [0.9]
  final double maxChildSize;

  /// A listener that monitors events bubbling up from the BottomSheet
  ///
  /// The [bottomSheetListener] is triggered with a [DraggableScrollableNotification]
  /// when changes occur in the BottomSheet's draggable scrollable area
  final BottomSheetListener? bottomSheetListener;

  /// Sets the background color of the dropdown
  ///
  /// Default Value: [Colors.transparent]
  final Color dropDownBackgroundColor;

  /// The padding applied to the dropdown container
  ///
  /// If not provided (i.e., null), the default value will be
  /// [EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom)]
  final EdgeInsets? dropDownPadding;

  /// The padding applied to the dropdown header
  ///
  /// If not provided (i.e., null), the default value will be
  /// [EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0)]
  final EdgeInsets? dropDownHeaderPadding;

  /// The widget displayed as the title of the bottom sheet
  /// This allows customization of the title content
  ///
  /// If not provided, no title will be displayed
  final Widget? bottomSheetTitle;

  /// Defines a custom widget to display as the child of the submit button
  /// when [enableMultipleSelection] is true
  ///
  /// This is typically used with an [ElevatedButton]
  /// If not provided, a default button child will be used
  final Widget? submitButtonChild;

  /// Specifies the text displayed on the submit button when [enableMultipleSelection] is true
  ///
  /// This is only used if a custom [submitButtonChild] widget is not provided
  ///
  /// Default Value: [Submit]
  final String submitButtonText;

  /// Defines a custom widget to display as the child of the clear button
  /// when [enableMultipleSelection] is true
  ///
  /// This is typically used with an [ElevatedButton]
  /// If not provided, a default button child will be used
  final Widget? clearButtonChild;

  /// Specifies the text displayed on the clear button when [enableMultipleSelection] is true
  ///
  /// This is only used if a custom [clearButtonChild] widget is not provided
  ///
  /// Default Value: [Clear]
  final String clearButtonText;

  /// Controls the visibility of the search widget
  ///
  /// Default Value: [true], The widget will be visible by default
  /// Set to [false] to hide the widget
  final bool isSearchVisible;

  /// The padding applied to the search text field
  ///
  /// If not provided (i.e., null), the default value will be
  /// [EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)]
  final EdgeInsets? searchTextFieldPadding;

  /// Defines a custom widget to display the text box for searching
  ///
  /// If you provide a custom widget, you must include a [TextEditingController]
  /// for the [TextFormField] to manage the input
  ///
  /// If null, the default [SearchTextField] widget will be used
  final TextFormField? searchWidget;

  /// Specifies the text displayed on the search widget as hint text
  ///
  /// Default Value: [Search]
  final String searchHintText;

  /// This is the fill color for the input field
  ///
  /// Default Value: [Colors.black12]
  final Color searchFillColor;

  /// This is the cursor color for the input field
  ///
  /// Default Value: [Colors.black]
  final Color searchCursorColor;

  /// Controls the visibility of the "select all" widget when [enableMultipleSelection] is true
  ///
  /// Default Value: [true]
  final bool isSelectAllVisible;

  /// The padding applied to the "select all" and "deselect all" TextButtons
  ///
  /// If null, [EdgeInsets.zero] will be applied as the default padding
  final EdgeInsets? selectAllTextButtonPadding;

  /// Defines a custom widget to display as the child of the selectAll text button
  /// when [enableMultipleSelection] and [isSelectAllVisible] is true
  ///
  /// This is typically used with an [TextButton]
  /// If not provided, a default text button child will be used
  final Widget? selectAllTextButtonChild;

  /// Specifies the text displayed on the selectAll text button
  /// when [enableMultipleSelection] and [isSelectAllVisible] is true
  ///
  /// This is only used if a custom [selectAllTextButtonChild] widget is not provided
  ///
  /// Default Value: [Select All]
  final String selectAllButtonText;

  /// Defines a custom widget to display as the child of the deSelectAll text button
  /// when [enableMultipleSelection] and [isSelectAllVisible] is true
  ///
  /// This is typically used with an [TextButton]
  /// If not provided, a default text button child will be used
  final Widget? deSelectAllTextButtonChild;

  /// Specifies the text displayed on the deSelectAll text button
  /// when [enableMultipleSelection] and [isSelectAllVisible] is true
  ///
  /// This is only used if a custom [deSelectAllTextButtonChild] widget is not provided
  ///
  /// Default Value: [Deselect All]
  final String deSelectAllButtonText;

  /// A delegate used to configure the custom search functionality in the dropdown
  final SearchDelegate<T>? searchDelegate;

  DropDown({
    Key? key,
    required this.data,
    this.onSelected,
    this.listItemBuilder,
    this.enableMultipleSelection = false,
    this.maxSelectedItems,
    this.onMaxSelectionReached,
    this.listViewPadding,
    this.listViewSeparatorWidget,
    this.listTileContentPadding,
    this.listTileColor = Colors.transparent,
    this.selectedListTileTrailingWidget = const Icon(
      Icons.check_box,
    ),
    this.deSelectedListTileTrailingWidget = const Icon(
      Icons.check_box_outline_blank,
    ),
    this.useRootNavigator = false,
    this.enableDrag = true,
    this.isDismissible = true,
    this.initialChildSize = 0.7,
    this.minChildSize = 0.3,
    this.maxChildSize = 0.9,
    this.bottomSheetListener,
    this.dropDownBackgroundColor = Colors.transparent,
    this.dropDownPadding,
    this.dropDownHeaderPadding,
    this.bottomSheetTitle,
    this.submitButtonChild,
    this.submitButtonText = 'Submit',
    this.clearButtonChild,
    this.clearButtonText = 'Clear',
    this.isSearchVisible = true,
    this.searchTextFieldPadding,
    this.searchWidget,
    this.searchHintText = 'Search',
    this.searchFillColor = Colors.black12,
    this.searchCursorColor = Colors.black,
    this.isSelectAllVisible = true,
    this.selectAllTextButtonPadding,
    this.selectAllTextButtonChild,
    this.selectAllButtonText = 'Select All',
    this.deSelectAllTextButtonChild,
    this.deSelectAllButtonText = 'Deselect All',
    this.searchDelegate,
  });
}

/// Manages the state and behavior of a dropdown
/// This includes configuring and displaying a modal bottom sheet containing the dropdown items
class DropDownState<T> {
  /// The `DropDown` configuration object that defines the behavior, appearance,
  /// and other properties of the dropdown menu
  final DropDown<T> dropDown;

  /// The shape of the bottom sheet
  ///
  /// If not provided (i.e., null), the default value will be
  /// [RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)))]
  final ShapeBorder? shapeBorder;

  DropDownState({
    required this.dropDown,
    this.shapeBorder,
  });

  /// Displays the dropdown menu as a modal bottom sheet
  ///
  /// [context] is the BuildContext used to display the modal bottom sheet
  ///
  /// This method uses the configurations defined in the `dropDown` object
  void showModal(BuildContext context) {
    showModalBottomSheet(
      useRootNavigator: dropDown.useRootNavigator,
      isScrollControlled: true,
      enableDrag: dropDown.enableDrag,
      isDismissible: dropDown.isDismissible,
      shape: shapeBorder ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15.0),
            ),
          ),
      context: context,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return MainBody<T>(dropDown: dropDown);
          },
        );
      },
    );
  }
}

/// This is main class to display the bottom sheet body
class MainBody<T> extends StatefulWidget {
  /// The `DropDown` configuration object that defines the behavior, appearance,
  /// and other properties of the dropdown menu
  final DropDown<T> dropDown;

  const MainBody({
    required this.dropDown,
    super.key,
  });

  @override
  State<MainBody<T>> createState() => _MainBodyState<T>();
}

class _MainBodyState<T> extends State<MainBody<T>> {
  /// This list will set when the list of data is not available
  List<SelectedListItem<T>> mainList = [];

  @override
  void initState() {
    super.initState();
    mainList = widget.dropDown.data;
    _setSearchWidgetListener();
  }

  @override
  Widget build(BuildContext context) {
    final isSelectAll = mainList.fold(true, (p, e) => p && (e.isSelected));
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: widget.dropDown.bottomSheetListener,
      child: DraggableScrollableSheet(
        initialChildSize: widget.dropDown.initialChildSize,
        minChildSize: widget.dropDown.minChildSize,
        maxChildSize: widget.dropDown.maxChildSize,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            color: widget.dropDown.dropDownBackgroundColor,
            padding: widget.dropDown.dropDownPadding ??
                EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: widget.dropDown.dropDownHeaderPadding ??
                      const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 10.0,
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Bottom sheet title text
                      (widget.dropDown.bottomSheetTitle != null)
                          ? Expanded(
                              child: widget.dropDown.bottomSheetTitle!,
                            )
                          : const Spacer(),

                      /// Submit Elevated Button
                      if (widget.dropDown.enableMultipleSelection)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: onSubmitButtonPressed,
                              child: widget.dropDown.submitButtonChild ??
                                  Text(widget.dropDown.submitButtonText),
                            ),

                            /// Clear Elevated Button
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: ElevatedButton(
                                onPressed: onClearButtonPressed,
                                child: widget.dropDown.clearButtonChild ??
                                    Text(widget.dropDown.clearButtonText),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                /// A [TextField] that displays a list of suggestions as the user types with clear button.
                if (widget.dropDown.isSearchVisible)
                  Padding(
                    padding: widget.dropDown.searchTextFieldPadding ??
                        const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                    child: widget.dropDown.searchWidget ??
                        SearchTextField(
                          dropDown: widget.dropDown,
                          onTextChanged: _buildSearchList,
                          searchHintText: widget.dropDown.searchHintText,
                          searchFillColor: widget.dropDown.searchFillColor,
                          searchCursorColor: widget.dropDown.searchCursorColor,
                        ),
                  ),

                /// Select or Deselect TextButton when enableMultipleSelection is enabled
                if (widget.dropDown.enableMultipleSelection &&
                    widget.dropDown.isSelectAllVisible &&
                    mainList.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: widget.dropDown.selectAllTextButtonPadding ??
                          EdgeInsets.zero,
                      child: TextButton(
                        onPressed: () => setState(() {
                          for (var element in mainList) {
                            element.isSelected = !isSelectAll;
                          }
                        }),
                        child: isSelectAll
                            ? widget.dropDown.deSelectAllTextButtonChild ??
                                Text(widget.dropDown.deSelectAllButtonText)
                            : widget.dropDown.selectAllTextButtonChild ??
                                Text(widget.dropDown.selectAllButtonText),
                      ),
                    ),
                  ),

                /// Listview (list of data with check box for multiple selection & on tile tap single selection)
                Flexible(
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: mainList.length,
                    padding: widget.dropDown.listViewPadding ?? EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      bool isSelected = mainList[index].isSelected;
                      return Material(
                        color: Colors.transparent,
                        clipBehavior: Clip.hardEdge,
                        child: ListTile(
                          onTap: () {
                            if (widget.dropDown.enableMultipleSelection) {
                              if (!isSelected &&
                                  widget.dropDown.maxSelectedItems != null) {
                                if (mainList
                                        .where((e) => e.isSelected)
                                        .length >=
                                    widget.dropDown.maxSelectedItems!) {
                                  widget.dropDown.onMaxSelectionReached?.call();
                                  return;
                                }
                              }
                              setState(() {
                                mainList[index].isSelected = !isSelected;
                              });
                            } else {
                              widget.dropDown.onSelected
                                  ?.call([mainList[index]]);
                              _onUnFocusKeyboardAndPop();
                            }
                          },
                          title: widget.dropDown.listItemBuilder
                                  ?.call(index, mainList[index]) ??
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mainList[index].data.toString(),
                                  ),
                                  if (mainList[index].description.isNotEmpty)
                                    Text(
                                      mainList[index].description,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                ],
                              ),
                          trailing: widget.dropDown.enableMultipleSelection
                              ? isSelected
                                  ? widget
                                      .dropDown.selectedListTileTrailingWidget
                                  : widget
                                      .dropDown.deSelectedListTileTrailingWidget
                              : const SizedBox.shrink(),
                          contentPadding:
                              widget.dropDown.listTileContentPadding ??
                                  const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                          tileColor: widget.dropDown.listTileColor,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => getSeparatorWidget,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget get getSeparatorWidget =>
      widget.dropDown.listViewSeparatorWidget ??
      const Divider(
        color: Colors.black12,
        height: 0,
      );

  /// Handle the submit button pressed
  void onSubmitButtonPressed() {
    List<SelectedListItem<T>> selectedList =
        widget.dropDown.data.where((element) => element.isSelected).toList();
    widget.dropDown.onSelected?.call(selectedList);
    _onUnFocusKeyboardAndPop();
  }

  /// Handle the clear button pressed
  void onClearButtonPressed() {
    for (final element in mainList) {
      element.isSelected = false;
    }
    setState(() {});
  }

  /// This helps when search enabled & show the filtered data or description in list.
  void _buildSearchList(String userSearchTerm) {
    final results = widget.dropDown.searchDelegate
            ?.call(userSearchTerm, widget.dropDown.data) ??
        widget.dropDown.data.where((element) {
          final dataContains = element.data
              .toString()
              .toLowerCase()
              .contains(userSearchTerm.toLowerCase());
          final descriptionContains = element.description
              .toLowerCase()
              .contains(userSearchTerm.toLowerCase());
          return dataContains || descriptionContains;
        });

    if (userSearchTerm.isEmpty) {
      mainList = widget.dropDown.data;
    } else {
      mainList = results.toList();
    }
    setState(() {});
  }

  /// This helps to UnFocus the keyboard & pop from the bottom sheet.
  void _onUnFocusKeyboardAndPop() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  /// This helps to add listener on search field controller
  void _setSearchWidgetListener() {
    TextFormField? searchField = widget.dropDown.searchWidget;
    searchField?.controller?.addListener(() {
      _buildSearchList(searchField.controller?.text ?? '');
    });
  }
}
