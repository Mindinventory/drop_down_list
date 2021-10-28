import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'drop_down_data_model.dart';

class DropDownPage extends StatefulWidget {
  const DropDownPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DropDownPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DropDownPage> {
  final List<DropDownData> _iconData = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(kTitle),
        ),
        body: ElevatedButton(
          onPressed: () {
            _showBottomSheet();
          },
          child: const Text(kClickMe),
        ));
  }

  // Bottom sheet with list data
  _showBottomSheet({Icon? icon, String? title}) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        isScrollControlled: false,
        builder: (context) {
          return Stack(
            children: [
              _DropDownListView(
                dropDownList: _iconData,
              ),
              _FloatingButton(
                dropDownList: _iconData,
                controller: _controller,
              ),
            ],
          );
        });
  }
}

class _DropDownListView extends StatelessWidget {
  final List<DropDownData> dropDownList;
  const _DropDownListView({Key? key, required this.dropDownList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: dropDownList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: dropDownList[index].icon,
            title: Text(
              dropDownList[index].title,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          );
        });
  }
}

class _FloatingButton extends StatelessWidget {
  final List<DropDownData> dropDownList;
  final TextEditingController controller;
  const _FloatingButton(
      {Key? key, required this.dropDownList, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton.small(
        onPressed: () {
          _showAlert(context);
        },
        backgroundColor: Colors.blue,
        elevation: 5,
        splashColor: Colors.grey,
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  _showAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text(kAddData),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    _AddTextField(
                      controller: controller,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              _SubmitButton(
                dropDownList: dropDownList,
                controller: controller,
              ),
            ],
          );
        });
  }
}

class _SubmitButton extends StatelessWidget {
  final List<DropDownData> dropDownList;
  final TextEditingController controller;
  const _SubmitButton(
      {Key? key, required this.dropDownList, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: const Text(kSubmit),
        onPressed: () {
          dropDownList.add(DropDownData(
              title: controller.text,
              icon: const Icon(
                Icons.ac_unit,
                size: 20.0,
              )));
          Navigator.pop(context);
        });
  }
}

class _AddTextField extends StatelessWidget {
  final TextEditingController controller;
  const _AddTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: kEnterData,
        // icon: Icon(Icons.account_box),
      ),
    );
  }
}
