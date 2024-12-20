import 'package:flutter/material.dart';

import 'drop_down.dart';

/// This is search text field class
class SearchTextField extends StatefulWidget {
  /// The `DropDown` configuration object that defines the behavior, appearance,
  /// and other properties of the dropdown menu
  final DropDown dropDown;

  /// Called when the user initiates a change to the search text field
  final Function(String) onTextChanged;

  /// Used to show the hint text into the search text field
  final String? searchHintText;

  /// The fill color of the search text field
  final Color? searchFillColor;

  /// The color of the cursor of the search text field
  final Color? searchCursorColor;

  const SearchTextField({
    required this.dropDown,
    required this.onTextChanged,
    this.searchHintText,
    this.searchFillColor,
    this.searchCursorColor,
    super.key,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _editingController,
      cursorColor: widget.searchCursorColor,
      onChanged: (value) {
        widget.onTextChanged(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.searchFillColor,
        contentPadding: const EdgeInsets.only(right: 15),
        hintText: widget.searchHintText,
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
    );
  }

  void onClearTap() {
    widget.onTextChanged('');
    _editingController.clear();
  }
}
