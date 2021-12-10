import 'package:drop_down_plugin/drop_down_plugin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'DropDownList',
      home: DropDownListExample(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class DropDownListExample extends StatefulWidget {
  const DropDownListExample({
    Key? key,
  }) : super(key: key);

  @override
  _DropDownListExampleState createState() => _DropDownListExampleState();
}

class _DropDownListExampleState extends State<DropDownListExample> {
  /// This is list of city which will pass to the drop down.
  final List<SelectedListItem> _listOfCities = [
    SelectedListItem(false, 'Tokyo'),
    SelectedListItem(false, 'New York'),
    SelectedListItem(false, 'London'),
    SelectedListItem(false, 'Paris'),
    SelectedListItem(false, 'Madrid'),
    SelectedListItem(false, 'Dubai'),
    SelectedListItem(false, 'Rome'),
    SelectedListItem(false, 'Barcelona'),
    SelectedListItem(false, 'Cologne'),
    SelectedListItem(false, 'Monte Carlo'),
    SelectedListItem(false, 'Puebla'),
    SelectedListItem(false, 'Florence'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DropDown list'),
      ),
      body: _appElevatedButton(),
    );
  }

  Widget _appElevatedButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 170.0),
        child: ElevatedButton(
          onPressed: () {
            DropDownState(
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
          },
          child: const Text('Click Me!!'),
        ),
      ),
    );
  }
}
