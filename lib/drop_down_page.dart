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
            showBottomSheet();
          },
          child: const Text(kClickMe),
        ));
  }

  // Bottom sheet with list data
  showBottomSheet({Icon? icon, String? title}) {
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
              _buildListview(),
              _buildFloatingAddButton(),
            ],
          );
        });
  }

  // alert to add data in bottom sheet list
  showAlert(BuildContext context) {
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
                    _buildTextFiled(),
                  ],
                ),
              ),
            ),
            actions: [
              _buildSubmitButton(),
            ],
          );
        });
  }

  // widgets
  Widget _buildListview() {
    return ListView.builder(
        itemCount: _iconData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: _iconData[index].icon,
            title: Text(
              _iconData[index].title,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          );
        });
  }

  Widget _buildFloatingAddButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton.small(
        onPressed: () {
          showAlert(context);
        },
        backgroundColor: Colors.blue,
        elevation: 5,
        splashColor: Colors.grey,
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  Widget _buildTextFiled() {
    return TextFormField(
      controller: _controller,
      decoration: const InputDecoration(
        labelText: kEnterData,
        // icon: Icon(Icons.account_box),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
        child: const Text(kSubmit),
        onPressed: () {
          _iconData.add(DropDownData(
              title: _controller.text,
              icon: const Icon(
                Icons.ac_unit,
                size: 20.0,
              )));
          Navigator.pop(context);
        });
  }
}
