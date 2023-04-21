# Dropdown List Choices
Highly versatile Widget to search through a single or multiple choices from bottom sheet list in a dialog box or a menu.

# Platforms
This plugin has been successfully tested on iOS, Android & web.

# Examples
The following examples are extracted from the example project available in the repository. More examples are available in this project.

# Samples of Dropdown list with choices

## Dropdown Multiple Selection
![drop-down-list](https://github.com/Mindinventory/drop_down_list/blob/main/assets/drop_down_multiple_selection.gif)

## Dropdown Single Selection
![drop-down-list](https://github.com/Mindinventory/drop_down_list/blob/main/assets/drop_down_single_selection.gif)

# How to Use
```dart
DropDownState(
      DropDown(
        bottomSheetTitle: const Text(
          kCities,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.cities ?? [],
        selectedItems: (List<dynamic> selectedList) {
          List<String> list = [];
          for(var item in selectedList) {
            if(item is SelectedListItem) {
              list.add(item.name);
            }
          }
          showSnackBar(list.toString());
        },
        enableMultipleSelection: true,
      ),
    ).showModal(context);
```

### Required parameters

##### data:
This property takes List<SelectedListItem> as a parameter and it is useful to display items in drop down list.

### Optional parameters

##### listBuilder:
This property takes int value as a parameter. This is use to set the initial segment from [segmentNames].

##### enableMultipleSelection:
This property takes Color value as a parameter. You can change the background color of animated segment. default value is `Color(0xff8AADFB)`

##### bottomSheetTitle:
This gives the bottom sheet title.

##### submitButtonChild:
You can set your custom submit button when the multiple selection is enabled.

##### selectedItems:
This will give the call back to the selected items from list.

##### dropDownBackgroundColor:
This will set the background color to the dropdown.

##### searchWidget:
This property takes TextFormField value as a parameter. [searchWidget] is use to show the text box for the searching. If you are passing your own widget then you must have to add [TextEditingController] for the [TextFormField].

##### isSearchVisible:
This property takes bool value as a parameter. [isSearchVisible] is use to manage the search widget visibility. by default it is [True] so widget will be visible.

##### searchHintText:
This property takes String value as a parameter. [searchHintText] is use to show the hint text into the search widget. by default it is 'Search' text.

##### isDismissible:
This property takes bool value as a parameter. [isDismissible] Specifies whether the bottom sheet will be dismissed when user taps on the scrim. If true, the bottom sheet will be dismissed when user taps on the scrim. by default it is **True**.

##### bottomSheetListener:
[bottomSheetListener] that listens for BottomSheet bubbling up the tree.


# LICENSE!

Dropdown list is [MIT-licensed](https://github.com/Mindinventory/drop_down_list/blob/main/LICENSE "MIT-licensed").

# Let us know!

We’d be really happy if you send us links to your projects where you use our component. Just send an email to sales@mindinventory.com and do let us know if you have any questions or suggestion regarding our work.
