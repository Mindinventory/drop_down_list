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
```
DropDownState(
      DropDown(
        submitButtonText: kDone,
        submitButtonColor: const Color.fromRGBO(70, 76, 222, 1),
        searchHintText: kSearch,
        bottomSheetTitle: kCities,
        searchBackgroundColor: Colors.black12,
        dataList: widget.cities ?? [],
        selectedItems: (List<dynamic> selectedList) {
          showSnackBar(selectedList.toString());
        },
        selectedItem: (String selected) {
          showSnackBar(selected);
          widget.textEditingController.text = selected;
        },
        enableMultipleSelection: false,
        searchController: _searchTextEditingController,
      ),
    ).showModal(context);
```


# LICENSE!

Dropdown list is [MIT-licensed](https://github.com/Mindinventory/drop_down_list/blob/main/LICENSE "MIT-licensed").

# Let us know!

We’d be really happy if you send us links to your projects where you use our component. Just send an email to sales@mindinventory.com and do let us know if you have any questions or suggestion regarding our work.
