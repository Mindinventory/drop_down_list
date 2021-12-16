// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class SearchTextField extends StatefulWidget {
//   final List<String> searchData;
//   const SearchTextField({
//     required this.searchData,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _SearchTextFieldState createState() => _SearchTextFieldState();
// }
//
// class _SearchTextFieldState extends State<SearchTextField> {
//   TextEditingController searchController = TextEditingController();
//
//   // Copy Main List into New List.
//
//   onItemChanged(String value) {
//     newDataList = List.from(widget.searchData);
//     setState(() {
//       newDataList = widget.searchData
//           .where((string) => string.toLowerCase().contains(value.toLowerCase()))
//           .toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: TextFormField(
//         controller: searchController,
//         cursorColor: Colors.black,
//         onChanged: onItemChanged,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.black12,
//           contentPadding:
//               const EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 15),
//           hintText: 'search',
//           border: const OutlineInputBorder(
//             borderSide: BorderSide(
//               width: 0,
//               style: BorderStyle.none,
//             ),
//             borderRadius: BorderRadius.all(
//               Radius.circular(8.0),
//             ),
//           ),
//           prefixIcon: const IconButton(
//             icon: Icon(Icons.search),
//             onPressed: null,
//           ),
//           suffixIcon: GestureDetector(
//             onTap: () {
//               searchController.clear();
//             },
//             child: const Icon(
//               Icons.cancel,
//               color: Colors.grey,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
