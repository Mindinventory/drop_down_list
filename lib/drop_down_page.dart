import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class DropDownPage extends StatefulWidget {
  const DropDownPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DropDownPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DropDownPage> {
  List<SelectedListItem> _mainListOfCities = [];
  //1
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();

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

  List list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(kTitle),
      ),
      body: ElevatedButton(
        onPressed: () {
          _showModal(context);
        },
        child: const Text(kClickMe),
      ),
    );
  }

  void _showModal(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          //3
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Cities',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                                onPressed: () {
                                  var selectedList = _listOfCities.where(
                                      (element) => element.isSelected == true);

                                  for (var element in selectedList) {
                                    list.add(element.name);
                                  }
                                  _scaffoldKey.currentState!.showSnackBar(
                                      SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(list.toString())));
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Done')),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: searchController,
                        cursorColor: Colors.black,
                        onChanged: (value) {
                          setState(() {
                            _buildSearchList(value);
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black12,
                          contentPadding: const EdgeInsets.only(
                              left: 0, bottom: 0, top: 0, right: 15),
                          hintText: 'search',
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          prefixIcon: const IconButton(
                            icon: Icon(Icons.search),
                            onPressed: null,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {});
                              searchController.clear();
                              _mainListOfCities.clear();
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          controller: scrollController,
                          //5
                          itemCount: (_mainListOfCities.isNotEmpty)
                              ? _mainListOfCities.length
                              : _listOfCities.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                //6
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 0),
                                    child: ListTile(
                                      title: Text(
                                        (_mainListOfCities.isNotEmpty)
                                            ? _mainListOfCities[index].name
                                            : _listOfCities[index].name,
                                      ),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          print('check box selected');
                                          setState(() {
                                            _listOfCities[index].isSelected =
                                                !_listOfCities[index]
                                                    .isSelected;

                                            // if (_mainListOfCities.isNotEmpty) {
                                            //   if (_mainListOfCities[index]
                                            //           .isSelected ==
                                            //       true) {
                                            //     _mainListOfCities[index] =
                                            //         SelectedListItem(
                                            //             true,
                                            //             _mainListOfCities[index]
                                            //                 .name);
                                            //   } else if (_mainListOfCities[
                                            //               index]
                                            //           .isSelected ==
                                            //       false) {
                                            //     list.removeWhere((element) =>
                                            //         element.name ==
                                            //         _mainListOfCities[index]
                                            //             .name);
                                            //   }
                                            // }

                                            list.clear();
                                          });
                                        },
                                        child: (_mainListOfCities.isNotEmpty)
                                            ? _mainListOfCities[index]
                                                    .isSelected
                                                ? const Icon(Icons.check_box)
                                                : const Icon(Icons
                                                    .check_box_outline_blank)
                                            : _listOfCities[index].isSelected
                                                ? const Icon(Icons.check_box)
                                                : const Icon(Icons
                                                    .check_box_outline_blank),
                                        // _listOfCities[index].isSelected
                                        //     ? const Icon(Icons.check_box)
                                        //     : const Icon(
                                        //         Icons.check_box_outline_blank),
                                      ),
                                    ),
                                  ),
                                ),
                                // (_mainListOfCities.isNotEmpty)
                                //     ? _showBottomSheetWithSearch(
                                //         index, _mainListOfCities)
                                //     : _showBottomSheetWithSearch(
                                //         index, _listOfCities),
                                onTap: () {
                                  //7
                                  _scaffoldKey.currentState!.showSnackBar(
                                      SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text((_mainListOfCities
                                                  .isNotEmpty)
                                              ? _mainListOfCities[index].name
                                              : _listOfCities[index].name)));
                                  Navigator.of(context).pop();
                                });
                          }),
                    )
                  ]);
                });
          });
        });
  }

  //8
  Widget _showBottomSheetWithSearch(
      int index, List<SelectedListItem> listOfCities) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: ListTile(
          title: Text(
            listOfCities[index].name,
          ),
          trailing: GestureDetector(
              onTap: () {
                setState(() {
                  _listOfCities[index] =
                      SelectedListItem(true, _listOfCities[index].name);
                });
              },
              child: _listOfCities[index].isSelected
                  ? const Icon(Icons.check_box)
                  : const Icon(Icons.check_box_outline_blank)),
        ),
      ),
    );
  }

  //9
  _buildSearchList(String userSearchTerm) {
    List<SelectedListItem> _searchList = [];

    for (int i = 0; i < _listOfCities.length; i++) {
      String name = _listOfCities[i].name;
      if (name.toLowerCase().contains(userSearchTerm.toLowerCase())) {
        _searchList.add(_listOfCities[i]);
      }
    }

    _mainListOfCities = _searchList;
    // return _searchList;
  }
}

class SelectedListItem {
  bool isSelected;
  String name;

  SelectedListItem(this.isSelected, this.name);
}
