import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: kTitle,
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// This is list of city which will pass to the drop down
  final List<SelectedListItem> _listOfCities = [
    SelectedListItem(
      name: kTokyo,
      value: "TYO",
    ),
    SelectedListItem(
      name: kNewYork,
      value: "NY",
    ),
    SelectedListItem(
      name: kLondon,
      value: "LDN",
    ),
    SelectedListItem(name: kParis),
    SelectedListItem(name: kMadrid),
    SelectedListItem(name: kDubai),
    SelectedListItem(name: kRome),
    SelectedListItem(name: kBarcelona),
    SelectedListItem(name: kCologne),
    SelectedListItem(name: kMonteCarlo),
    SelectedListItem(name: kPuebla),
    SelectedListItem(name: kFlorence),
  ];

  /// This is register text field controllers
  final TextEditingController _fullNameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _phoneNumberTextEditingController =
      TextEditingController();
  final TextEditingController _cityTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _fullNameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _phoneNumberTextEditingController.dispose();
    _cityTextEditingController.dispose();
    _passwordTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30.0),
              const Text(
                kRegister,
                style: TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15.0),
              AppTextField(
                textEditingController: _fullNameTextEditingController,
                title: kFullName,
                hint: kEnterYourName,
                isCitySelected: false,
              ),
              AppTextField(
                textEditingController: _emailTextEditingController,
                title: kEmail,
                hint: kEnterYourEmail,
                isCitySelected: false,
              ),
              AppTextField(
                textEditingController: _phoneNumberTextEditingController,
                title: kPhoneNumber,
                hint: kEnterYourPhoneNumber,
                isCitySelected: false,
              ),
              AppTextField(
                textEditingController: _cityTextEditingController,
                title: kCity,
                hint: kChooseYourCity,
                isCitySelected: true,
                cities: _listOfCities,
              ),
              AppTextField(
                textEditingController: _passwordTextEditingController,
                title: kPassword,
                hint: kAddYourPassword,
                isCitySelected: false,
              ),
              const SizedBox(height: 15.0),
              const AppElevatedButton(),
            ],
          ),
        ),
      ),
    );
  }
}

/// This is Common App text field class
class AppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String title;
  final String hint;
  final bool isCitySelected;
  final List<SelectedListItem>? cities;

  const AppTextField({
    required this.textEditingController,
    required this.title,
    required this.hint,
    required this.isCitySelected,
    this.cities,
    super.key,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(height: 5.0),
        TextFormField(
          controller: widget.textEditingController,
          cursorColor: Colors.black,
          readOnly: widget.isCitySelected,
          onTap: widget.isCitySelected
              ? () {
                  FocusScope.of(context).unfocus();
                  onTextFieldTap();
                }
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            contentPadding: const EdgeInsets.only(
              left: 8,
              bottom: 0,
              top: 0,
              right: 15,
            ),
            hintText: widget.hint,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }

  /// This is on text changed method which will display on city text field on changed
  void onTextFieldTap() {
    DropDownState(
      dropDown: DropDown(
        isDismissible: true,
        bottomSheetTitle: const Text(
          kCities,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonText: 'Save',
        clearButtonText: 'Clear',
        data: widget.cities ?? [],
        onSelected: (List<dynamic> selectedList) {
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
            }
          }
          showSnackBar(list.toString());
        },
        enableMultipleSelection: true,
        maxSelectedItems: 3,
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

/// This is common class for 'REGISTER' elevated button
class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(70, 76, 222, 1),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        child: const Text(
          kREGISTER,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
