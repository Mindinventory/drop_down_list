## Dropdown List Choices 
Highly versatile Widget to search through a single or multiple choices from bottom sheet list in a dialog box or a menu.

# Platforms
This plugin has been successfully tested on iOS, Android & web.

# Examples 
The following examples are extracted from the example project available in the repository. More examples are available in this project.

# Samples of Dropdown list with choices

## Dropdown Multiple Selection 
![Dropdown list]()

## Dropdown Single Selection 
![Dropdown list]()

# Installation
`drop_down_list: ^1.0.0`

# How to Use
`DropDownState(
              DropDown(
                submitButtonText: 'Submit',
                submitButtonColor: Colors.blue,
                searchHintText: 'Search.....',
                bottomSheetTitle: 'Cities',
                searchBackgroundColor: Colors.black12,
                listOfData: _listOfCities,
                callbackForMultipleSelectedItems: (List<dynamic> selectedList) {
                  print('Multiple Selected ::: $selectedList');
                },
                callbackForSelectedItem: (String selected) {
                  print('Single Selected ::: $selected');
                },
              ),
            ).showModal(context);
`

# LICENSE!

Dropdown list is [MIT-licensed](/LICENSE).

# Let us know!

We’d be really happy if you send us links to your projects where you use our component. Just send an email to sales@mindinventory.com and do let us know if you have any questions or suggestion regarding our work.


