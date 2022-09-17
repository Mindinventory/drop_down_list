import 'package:flutter/material.dart';

import 'drop_down.dart';

/// This is search text field class.
class AppTextField extends StatefulWidget {
  final DropDown dropDown;
  final Function(String) onTextChanged;
  final TextEditingController? editingController;

  AppTextField({required this.dropDown, required this.onTextChanged, Key? key, this.editingController}) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: widget.editingController,
        autofocus: true,
        cursorColor: Colors.black,
        onChanged: (value) {
          widget.onTextChanged(value);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          contentPadding: const EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 15),
          hintText: 'Search',
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
            onTap: onClearTap,
            child: const Icon(
              Icons.cancel,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  void onClearTap() {
    widget.editingController?.clear();
  }
}
