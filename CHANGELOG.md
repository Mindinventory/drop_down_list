## 2.0.0

* **BREAKING CHANGE**: Changed `SelectedListItem` class from a non-generic to a generic class: The
  `SelectedListItem` now accepts a type parameter `T` to represent the data it holds.
* Due to this change, relevant callbacks and properties where `SelectedListItem` is used also need
  to be updated or refactored to accommodate the generic type.
* Added `SearchDelegate` to enable flexible search functionality based on a user-provided query.
* Revised the example code to reflect the change of `SelectedListItem` from a non-generic to a
  generic class.
* Fixed the issue.
    - [#31](https://github.com/Mindinventory/drop_down_list/issues/31) - error: The argument type
      List<Object> can't be assigned to the parameter type List<SelectedListItem>.
* Updated the library details.

## 1.0.0

* Added `initial`, `minimum` and `maximum` fractional values of the DraggableScrollableSheet.
* Added customizable trailing widgets for selected and deselected list items in multiple selection
  mode.
* Added `separator` widget for list views to enhance item separation.
* Added customization options for `padding`, `colors`, and `button texts` in the dropdown list
  views.
* Merged the PR.
    - [#33](https://github.com/Mindinventory/drop_down_list/pull/33) - Necessary improvements to
      check icons, Thanks to [raulgarciaalcaraz-zero](https://github.com/raulgarciaalcaraz-zero).
* Fixed the issue.
    - [#28](https://github.com/Mindinventory/drop_down_list/issues/28) - Error overflowing
      RenderFlex has an orientation of Axis vertical.
* Refactored and improved the code.
* Updated the library details.

## 0.0.8

* **BREAKING CHANGE**: The library now requires Dart version `3.2.0` or higher,
  and Flutter version `3.16.0` or higher.
* Merged the PRs.
    - [#22](https://github.com/Mindinventory/drop_down_list/pull/22) - ListTile's onTap to select,
      Thanks to [MrLightful](https://github.com/MrLightful).
    - [#23](https://github.com/Mindinventory/drop_down_list/pull/23) - Select All button,
      Thanks to [MrLightful](https://github.com/MrLightful).
    - [#26](https://github.com/Mindinventory/drop_down_list/pull/26) - Allow passing fill and cursor
      color to dropdown, Thanks to [joshuachinemezu](https://github.com/joshuachinemezu).
* Refactored the code of the above PRs.
* Updated the library details.

## 0.0.7

* Fixed the issue.
    - [#19](https://github.com/Mindinventory/drop_down_list/issues/19) - How to limit the number
      of items selected with multiple selection.
* Merged the PR.
    - [#21](https://github.com/Mindinventory/drop_down_list/pull/21) - Bring project up to date,
      Thanks to [MrLightful](https://github.com/MrLightful).
* Refactored the code.
* Updated the library details.

## 0.0.6

* Fixed the issues.
    - [#13](https://github.com/Mindinventory/drop_down_list/issues/13) - How to limit or control the
      height of bottom modal.
    - [#14](https://github.com/Mindinventory/drop_down_list/issues/14) - Search hint text has an
      offset when not selected.
    - [#15](https://github.com/Mindinventory/drop_down_list/issues/15) - i need btn to remove
      selected items.
    - [#18](https://github.com/Mindinventory/drop_down_list/issues/18) - Setting background color.
* Updated the library details.

## 0.0.5

* Fixed the issues.
    - [#7](https://github.com/Mindinventory/drop_down_list/issues/7) - Change hintText.
    - [#8](https://github.com/Mindinventory/drop_down_list/issues/8) - No dismissible sheet.
    - [#11](https://github.com/Mindinventory/drop_down_list/issues/11) - text field clean is not
      working.
    - [#12](https://github.com/Mindinventory/drop_down_list/issues/12) - Why make this dynamic.
* Updated the library details.

## 0.0.4

* Fixed the issue.
    - [#5](https://github.com/Mindinventory/drop_down_list/issues/5) - Support for search bar
      visibility.
* Updated the library details.

## 0.0.3

* Added the support for widget customizations.
* Fixed the issue.
    - [#2](https://github.com/Mindinventory/drop_down_list/issues/2) - Change background color.
* Updated the library details.

## 0.0.2

* Updated the library details.

## 0.0.1

* Initial release of `drop_down_list` library.