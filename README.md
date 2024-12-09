# drop_down_bottom_sheet

<a href="https://flutter.dev/"><img src="https://img.shields.io/badge/flutter-website-deepskyblue.svg" alt="Flutter Website"></a>
<a href="https://dart.dev"><img src="https://img.shields.io/badge/dart-website-deepskyblue.svg" alt="Dart Website"></a>
<a href="https://developer.android.com" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Android-deepskyblue">
</a>
<a href="https://developer.apple.com/ios/" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-iOS-deepskyblue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Web-deepskyblue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Mac-deepskyblue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Linux-deepskyblue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Windows-deepskyblue">
</a>
<a href=""><img src="https://app.codacy.com/project/badge/Grade/dc683c9cc61b499fa7cdbf54e4d9ff35"/></a>
<a href="https://github.com/raulgarciaalcaraz-zero/drop_down_list/blob/master/LICENSE" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/github/license/Mindinventory/drop_down_list"></a>
<a href="https://pub.dev/packages/drop_down_list"><img src="https://img.shields.io/pub/v/drop_down_list?color=as&label=drop_down_list&logo=as1&logoColor=blue&style=social"></a>
<a href="https://github.com/raulgarciaalcaraz-zero/drop_down_list"><img src="https://img.shields.io/github/stars/Mindinventory/drop_down_list?style=social" alt="MIT License"></a>

Highly versatile Widget to search through a single or multiple choices from bottom sheet list in a dialog box or a menu.

# Preview

## Dropdown with Multiple Selection
![drop-down-list](https://github.com/Mindinventory/drop_down_list/blob/main/assets/drop_down_multiple_selection.gif?raw=true)

## Dropdown with Single Selection
![drop-down-list](https://github.com/Mindinventory/drop_down_list/blob/main/assets/drop_down_single_selection.gif?raw=true)

# How to Use

Import it to your project file

```dart
import 'package:drop_down_bottom_sheed/drop_down_list.dart';
```

And add it in its most basic form like it:

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
        onSelected: (List<dynamic> selectedList) {
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

##### listItemBuilder:
This property takes a builder function with `SelectedListItem` as argument. It is used to customize the rendering of the list items.

##### enableMultipleSelection:
This property takes Color value as a parameter. You can change the background color of animated segment. default value is `Color(0xff8AADFB)`

##### bottomSheetTitle:
This gives the bottom sheet title.

##### submitButtonChild:
You can set your custom submit button when the multiple selection is enabled.

##### onSelected:
This will give the call back to the selected items from list.

##### clearButtonChild:
You can set your custom clear button when the multiple selection is enabled.

##### dropDownBackgroundColor:
This will set the background color to the dropdown.

##### maxSelectedItems
Number of items that can be selected when multiple selection is enabled

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

## Guideline for contributors

* Contribution towards our repository is always welcome, we request contributors to create a pull
  request for development.

## Guideline to report an issue/feature request

It would be great for us if the reporter can share the below things to understand the root cause of
the issue.

* Library version
* Code snippet
* Logs if applicable
* Device specification like (Manufacturer, OS version, etc)
* Screenshot/video with steps to reproduce the issue
* Library used

## LICENSE!

**drop_down_list** is [MIT-licensed.](https://github.com/Mindinventory/drop_down_list/blob/main/LICENSE)
