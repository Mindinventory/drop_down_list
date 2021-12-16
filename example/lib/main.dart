import 'package:drop_down_plugin/drop_down_plugin.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() {
  runApp(
    const MaterialApp(
      title: kTitle,
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
    SelectedListItem(false, kTokyo),
    SelectedListItem(false, kNewYork),
    SelectedListItem(false, kLondon),
    SelectedListItem(false, kParis),
    SelectedListItem(false, kMadrid),
    SelectedListItem(false, kDubai),
    SelectedListItem(false, kRome),
    SelectedListItem(false, kBarcelona),
    SelectedListItem(false, kCologne),
    SelectedListItem(false, kMonteCarlo),
    SelectedListItem(false, kPuebla),
    SelectedListItem(false, kFlorence),
  ];
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: _mainBody(),
      ),
    );
  }

  Widget _mainBody() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            kRegister,
            style: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          AppTextField(
            controller: fullNameController,
            strTextFiledTitle: kFullName,
            strHint: kEnterYourName,
            isCitySelected: false,
          ),
          AppTextField(
            controller: emailController,
            strTextFiledTitle: kEmail,
            strHint: kEnterYourEmail,
            isCitySelected: false,
          ),
          AppTextField(
            controller: phoneNumberController,
            strTextFiledTitle: kPhoneNumber,
            strHint: kEnterYourPhoneNumber,
            isCitySelected: false,
          ),
          AppTextField(
            controller: cityController,
            strTextFiledTitle: kCity,
            strHint: kChooseYourCity,
            isCitySelected: true,
            listOfCities: _listOfCities,
          ),
          AppTextField(
            controller: passwordController,
            strTextFiledTitle: kPassword,
            strHint: kAddYourPassword,
            isCitySelected: false,
          ),
          const SizedBox(
            height: 15.0,
          ),
          _AppElevatedButton(),
        ],
      ),
    );
  }
}

class AppTextField extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  final String strTextFiledTitle;
  final String strHint;
  final bool isCitySelected;
  final List<SelectedListItem>? listOfCities;
  AppTextField({
    required this.controller,
    required this.strTextFiledTitle,
    required this.strHint,
    required this.isCitySelected,
    this.listOfCities,
    Key? key,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  TextEditingController searchController = TextEditingController();

  void onTextFieldTap() {
    DropDownState(
      DropDown(
        submitButtonText: kDone,
        submitButtonColor: const Color.fromRGBO(70, 76, 222, 1),
        searchHintText: kSearch,
        bottomSheetTitle: kCities,
        searchBackgroundColor: Colors.black12,
        dataList: widget.listOfCities ?? [],
        selectedItems: (List<dynamic> selectedList) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('$selectedList'),
          ));
        },
        selectedItem: (String selected) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(selected),
          ));
          widget.controller.text = selected;
        },
        enableMultipleSelection: true,
        searchController: searchController,
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.strTextFiledTitle),
        const SizedBox(
          height: 5.0,
        ),
        TextFormField(
          controller: widget.controller,
          cursorColor: Colors.black,
          onTap: widget.isCitySelected
              ? () {
                  FocusScope.of(context).unfocus();
                  onTextFieldTap();
                }
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            contentPadding: const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
            hintText: widget.strHint,
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
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}

class _AppElevatedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text(
          kREGISTER,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
        ),
        style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(70, 76, 222, 1),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
