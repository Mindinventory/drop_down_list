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
  final List<SelectedListItem<String>> _listOfCities = [
    SelectedListItem<String>(data: kTokyo),
    SelectedListItem<String>(data: kNewYork),
    SelectedListItem<String>(data: kLondon),
    SelectedListItem<String>(data: kParis),
    SelectedListItem<String>(data: kMadrid),
    SelectedListItem<String>(data: kDubai),
    SelectedListItem<String>(data: kRome),
    SelectedListItem<String>(data: kBarcelona),
    SelectedListItem<String>(data: kCologne),
    SelectedListItem<String>(data: kMonteCarlo),
    SelectedListItem<String>(data: kPuebla),
    SelectedListItem<String>(data: kFlorence),
  ];

  /// This is list of language with custom model which will pass to the drop down
  final List<SelectedListItem<LanguageModel>> _listOfLanguages = [
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kEnglish, code: kEn),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kSpanish, code: kEs),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kFrench, code: kFr),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kGerman, code: kDe),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kChinese, code: kZh),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kHindi, code: kHi),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kArabic, code: kAr),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kRussian, code: kRu),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kJapanese, code: kJa),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kPortuguese, code: kPt),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kItalian, code: kIt),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kKorean, code: kKo),
    ),
  ];

  /// This is register text field controllers
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _cityTextEditingController =
      TextEditingController();
  final TextEditingController _languageTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _cityTextEditingController.dispose();
    _languageTextEditingController.dispose();
    _passwordTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
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
                textEditingController: _nameTextEditingController,
                title: kName,
                hint: kEnterYourName,
              ),
              AppTextField(
                textEditingController: _emailTextEditingController,
                title: kEmail,
                hint: kEnterYourEmail,
              ),
              AppTextField(
                textEditingController: _cityTextEditingController,
                title: kCity,
                hint: kChooseYourCity,
                isReadOnly: true,
                onTextFieldTap: onCityTextFieldTap,
              ),
              AppTextField(
                textEditingController: _languageTextEditingController,
                title: kLanguage,
                hint: kChooseYourLanguage,
                isReadOnly: true,
                onTextFieldTap: onLanguageTextFieldTap,
              ),
              AppTextField(
                textEditingController: _passwordTextEditingController,
                title: kPassword,
                hint: kAddYourPassword,
                isReadOnly: false,
              ),
              const SizedBox(height: 15.0),
              const AppElevatedButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Handles the text field tap for the city
  void onCityTextFieldTap() async {
    await DropDownState<String>(
      dropDown: DropDown<String>(
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
        data: _listOfCities,
        onSelected: (selectedItems) {
          List<String> list = [];
          for (var item in selectedItems) {
            list.add(item.data);
          }
          showSnackBar(list.toString());
        },
        enableMultipleSelection: true,
        maxSelectedItems: 3,
      ),
    ).showModal(context);
  }

  /// Handles the text field tap for the language
  void onLanguageTextFieldTap() async {
    await DropDownState<LanguageModel>(
      dropDown: DropDown<LanguageModel>(
        isDismissible: true,
        bottomSheetTitle: const Text(
          kLanguages,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonText: 'Save',
        clearButtonText: 'Clear',
        data: _listOfLanguages,
        listItemBuilder: (index, dataItem) {
          return Text(
            '${dataItem.data.name} : ${dataItem.data.code}',
          );
        },
        onSelected: (selectedItems) {
          List<String> list = [];
          for (var item in selectedItems) {
            list.add('${item.data.name} : ${item.data.code}');
          }
          showSnackBar(list.toString());
        },
        searchDelegate: (query, dataItems) {
          return dataItems
              .where((item) =>
                  item.data.name.toLowerCase().contains(query.toLowerCase()) ||
                  item.data.code.toLowerCase().contains(query.toLowerCase()))
              .toList();
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

/// This is Common App text field class
class AppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String title;
  final String hint;
  final bool isReadOnly;
  final VoidCallback? onTextFieldTap;

  const AppTextField({
    required this.textEditingController,
    required this.title,
    required this.hint,
    this.isReadOnly = false,
    this.onTextFieldTap,
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
          readOnly: widget.isReadOnly,
          onTap: widget.isReadOnly
              ? () {
                  FocusScope.of(context).unfocus();
                  widget.onTextFieldTap?.call();
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

/// This is custom model class which we will use in drop down
class LanguageModel {
  final String name;
  final String code;

  LanguageModel({
    required this.name,
    required this.code,
  });
}
