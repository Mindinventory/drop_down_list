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
            'Register',
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
            strTextFiledTitle: 'Full Name',
            strHint: 'Enter your name',
            isCitySelected: false,
          ),
          AppTextField(
            controller: emailController,
            strTextFiledTitle: 'Email',
            strHint: 'Enter your email',
            isCitySelected: false,
          ),
          AppTextField(
            controller: phoneNumberController,
            strTextFiledTitle: 'Phone Number',
            strHint: 'Enter your phone number',
            isCitySelected: false,
          ),
          AppTextField(
            controller: cityController,
            strTextFiledTitle: 'City',
            strHint: 'Choose your city',
            isCitySelected: true,
            listOfCities: _listOfCities,
          ),
          AppTextField(
            controller: passwordController,
            strTextFiledTitle: 'Password',
            strHint: 'Add your password',
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
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        submitButtonText: 'Submit',
        submitButtonColor: const Color.fromRGBO(70, 76, 222, 1),
        searchHintText: 'Search.....',
        bottomSheetTitle: 'Cities',
        searchBackgroundColor: Colors.black12,
        listOfData: widget.listOfCities,
        callbackForMultipleSelectedItems: (List<dynamic> selectedList) {
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text('$selectedList'),
          // ));
        },
        callbackForSelectedItem: (String selected) {
          print('Single Selected ::: $selected');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(selected),
          ));
          widget.controller.text = selected;
        },
        isSelectedMultiple: false,
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
          'REGISTER',
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
