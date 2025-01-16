# drop_down_list

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
<a href="https://github.com/Mindinventory/drop_down_list/blob/main/LICENSE" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/github/license/Mindinventory/drop_down_list"></a>
<a href="https://pub.dev/packages/drop_down_list"><img src="https://img.shields.io/pub/v/drop_down_list?color=as&label=drop_down_list&logo=as1&logoColor=blue&style=social"></a>
<a href="https://github.com/Mindinventory/drop_down_list"><img src="https://img.shields.io/github/stars/Mindinventory/drop_down_list?style=social" alt="MIT License"></a>

A customizable dropdown widget supporting single/multiple selection, integrated search in a bottom
sheet, generic support for flexible, type-safe handling of custom data.

# Preview

### Dropdown with a Multiple Selection

![drop_down_with_multiple_selection](https://github.com/Mindinventory/drop_down_list/raw/main/screenshots/drop_down_with_multiple_selection.gif)

### Dropdown with a Single Selection

![drop_down_with_single_selection](https://github.com/Mindinventory/drop_down_list/raw/main/screenshots/drop_down_with_single_selection.gif)

## Basic Usage

Import it to your project file

```dart
import 'package:drop_down_list/drop_down_list.dart';
```

And add it in its most basic form like it:

```dart
DropDownState<String>(
  dropDown: DropDown<String>(
    data: <SelectedListItem<String>>[
      SelectedListItem<String>(data: 'Tokyo'),
      SelectedListItem<String>(data: 'New York'),
      SelectedListItem<String>(data: 'London'),
    ],
    onSelected: (selectedItems) {
      List<String> list = [];
      for (var item in selectedItems) {
        list.add(item.data);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            list.toString(),
          ),
        ),
      );
    },
  ),
).showModal(context);
```

## Required parameters of DropDown

| Parameter                        | Description                                                    |
|----------------------------------|----------------------------------------------------------------|
| `List<SelectedListItem<T>> data` | The list of generic data items to be displayed in the dropdown |

## Optional parameters of DropDown

| Parameter                                  | Description                                                                                                                                        |
|--------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| `List<SelectedListItem<T>> description` | The description to be displayed under the data items in the dropdown |
| `ItemSelectionCallBack<T>? onSelected`     | A callback function triggered when items are selected from the list                                                                                |
| `ListItemBuilder<T>? listItemBuilder`      | A function that takes an `[index]` and `[dataItem]` as a parameter and returns a custom widget to display for the list item at that index          |
| `int? maxSelectedItems`                    | The maximum number of items that can be selected when `[enableMultipleSelection]` is true                                                          |
| `VoidCallback? onMaxSelectionReached`      | A callback function triggered when the maximum selection limit is reached                                                                          |
| `EdgeInsets? listViewPadding`              | The padding applied to the `ListView` that contains the dropdown items                                                                             |
| `Widget? listViewSeparatorWidget`          | The widget used as a separator between items in the dropdown list                                                                                  |
| `EdgeInsets? listTileContentPadding`       | The padding applied to the content of each `ListTile` in the dropdown list                                                                         |
| `BottomSheetListener? bottomSheetListener` | A listener that monitors events bubbling up from the BottomSheet                                                                                   |
| `EdgeInsets? dropDownPadding`              | The padding applied to the dropdown container                                                                                                      |
| `EdgeInsets? dropDownHeaderPadding`        | The padding applied to the dropdown header                                                                                                         |
| `Widget? bottomSheetTitle`                 | The widget displayed as the title of the bottom sheet                                                                                              |
| `Widget? submitButtonChild`                | Defines a custom widget to display as the child of the submit button when `[enableMultipleSelection]` is true                                      |
| `Widget? clearButtonChild`                 | Defines a custom widget to display as the child of the clear button when `[enableMultipleSelection]` is true                                       |
| `EdgeInsets? searchTextFieldPadding`       | The padding applied to the search text field                                                                                                       |
| `TextFormField? searchWidget`              | Defines a custom widget to display the text box for searching                                                                                      |
| `EdgeInsets? selectAllTextButtonPadding`   | The padding applied to the "select all" and "deselect all" TextButtons                                                                             |
| `Widget? selectAllTextButtonChild`         | Defines a custom widget to display as the child of the selectAll text button when `[enableMultipleSelection]` and `[isSelectAllVisible]` is true   |
| `Widget? deSelectAllTextButtonChild`       | Defines a custom widget to display as the child of the deSelectAll text button when `[enableMultipleSelection]` and `[isSelectAllVisible]` is true |
| `SearchDelegate<T>? searchDelegate`        | A delegate used to configure the custom search functionality in the dropdown                                                                       |

## Optional parameters of DropDown with Default value

| Parameter                                 | Default                             | Description                                                                                                                     |
|-------------------------------------------|-------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| `bool enableMultipleSelection`            | false                               | Enables single or multiple selection for the drop down list items                                                               |
| `Color listTileColor`                     | Colors.transparent                  | Defines the background color of each `ListTile` in the dropdown list                                                            |
| `Widget selectedListTileTrailingWidget`   | Icon(Icons.check_box)               | The widget displayed as a trailing icon when a list item is selected                                                            |
| `Widget deSelectedListTileTrailingWidget` | Icon(Icons.check_box_outline_blank) | The widget displayed as a trailing icon when a list item is not selected                                                        |
| `bool useRootNavigator`                   | false                               | Specifies whether a modal bottom sheet should be displayed using the root navigator                                             |
| `bool enableDrag`                         | true                                | Specifies whether the bottom sheet can be dragged up and down and dismissed by swiping downwards                                |
| `bool isDismissible`                      | true                                | Specifies whether the bottom sheet will be dismissed when the user taps on the scrim                                            |
| `double initialChildSize`                 | 0.7                                 | The initial fractional value of DraggableScrollableSheet                                                                        |
| `double minChildSize`                     | 0.3                                 | The minimum fractional value of DraggableScrollableSheet                                                                        |
| `double maxChildSize`                     | 0.9                                 | The maximum fractional value of DraggableScrollableSheet                                                                        |
| `Color dropDownBackgroundColor`           | Colors.transparent                  | Sets the background color of the dropdown                                                                                       |
| `String submitButtonText`                 | 'Submit'                            | Specifies the text displayed on the submit button when `[enableMultipleSelection]` is true                                      |
| `String clearButtonText`                  | 'Clear'                             | Specifies the text displayed on the clear button when `[enableMultipleSelection]` is true                                       |
| `bool isSearchVisible`                    | true                                | Controls the visibility of the search widget                                                                                    |
| `String searchHintText`                   | 'Search'                            | Specifies the text displayed on the search widget as hint text                                                                  |
| `Color searchFillColor`                   | Colors.black12                      | This is the fill color for the input field                                                                                      |
| `Color searchCursorColor`                 | Colors.black                        | This is the cursor color for the input field                                                                                    |
| `bool isSelectAllVisible`                 | true                                | Controls the visibility of the "select all" widget when `[enableMultipleSelection]` is true                                     |
| `String selectAllButtonText`              | 'Select All'                        | Specifies the text displayed on the selectAll text button when `[enableMultipleSelection]` and `[isSelectAllVisible]` is true   |
| `String deSelectAllButtonText`            | 'Deselect All'                      | Specifies the text displayed on the deSelectAll text button when `[enableMultipleSelection]` and `[isSelectAllVisible]` is true |

## Required parameters of DropDownState

| Parameter              | Description                                                                                                          |
|------------------------|----------------------------------------------------------------------------------------------------------------------|
| `DropDown<T> dropDown` | The `DropDown` configuration object that defines the behavior, appearance, and other properties of the dropdown menu |

## Optional parameters of DropDownState

| Parameter                  | Description                   |
|----------------------------|-------------------------------|
| `ShapeBorder? shapeBorder` | The shape of the bottom sheet |

## Method of DropDownState

| Method                                 | Description                                        |
|----------------------------------------|----------------------------------------------------|
| `void showModal(BuildContext context)` | Displays the dropdown menu as a modal bottom sheet |

## Guideline for contributors

* Contributions to our repository are always welcome! We encourage contributors to submit pull
  requests for development and improvements.

## Guideline for Reporting an Issue or Feature Request

To help us better understand and resolve the issue, please include the following details when
reporting:

* Library version
* Code snippet
* Logs (if applicable)
* Device specifications (e.g., manufacturer, OS version)
* Screenshot or video with steps to reproduce the issue
* Any other relevant libraries used

## LICENSE!

**drop_down_list**
is [MIT-licensed.](https://github.com/Mindinventory/drop_down_list/blob/main/LICENSE)

## Let us know!

We’d be really happy if you send us links to your projects where you use our open-source libraries.
Just send an email to [sales@mindinventory.com](mailto:sales@mindinventory.com) And do let us know
if you have any questions or suggestion regarding our work.

Visit our website [mindinventory.com](https://www.mindinventory.com)

Let us know if you are interested to building Apps or Designing Products.
<p><a href="https://www.mindinventory.com/contact-us.php?utm_source=gthb&utm_medium=repo&utm_campaign=drop_down_list" target="__blank">
<img src="https://github.com/Mindinventory/drop_down_list/raw/main/assets/have_a_project_button.png" width="203" height="43"  alt="flutter app development">
</a></p>
