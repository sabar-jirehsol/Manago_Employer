import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:searchfield/searchfield.dart';

import '../utils/color_constants.dart';





// class SearchableDD extends StatelessWidget {
//   final String? hintText;
//   final TextStyle? hintStyle;
//   final String? label;
//  final  TextStyle? labelStyle;
//   final String? selectedItem;
//   final  items;
//   final Function? onChanged;
//   final Function? validate;
//   final bool? showSelectedItem;
//   final bool? showClearButton;
//   final TextEditingController? controller; // Add TextEditingController here
//
//   SearchableDD(
//       {
//         this.hintText,
//         this.hintStyle,
//         this.controller,
//         this.label,
//         this.labelStyle,
//         this.selectedItem,
//         this.items,
//         this.onChanged,
//         this.validate,
//         this.showSelectedItem = true,
//         this.showClearButton = false});
//   @override
//   Widget build(BuildContext context) {
//     return DropdownSearch<String>(
//
//       // controller: controller, // Pass the controller to DropdownSearch
//
//       validator: (v){
//         return validate!(v);
//       },
//       showClearButton: showClearButton!,
//       // searchBoxDecoration: InputDecoration(
//       //     labelStyle: TextStyle(fontSize: 18),
//       //     contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//       //     hintText: hintText,
//       //     hintStyle: TextStyle(fontSize: 18),
//       //     enabledBorder: OutlineInputBorder(
//       //         borderSide: BorderSide(color: kGreyColor),
//       //         borderRadius: BorderRadius.circular(10)),
//       //     focusedBorder: OutlineInputBorder(
//       //         borderSide: BorderSide(color: kGreyColor),
//       //         borderRadius: BorderRadius.circular(10))),
//
//       dropdownSearchDecoration: InputDecoration(
//         labelStyle: labelStyle??TextStyle(fontSize: 18,),
//         labelText: label,
//         hintText: hintText,
//         hintStyle: hintStyle??TextStyle(fontSize: 18,color: Colors.grey),
//         contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: kGreyColor),
//             borderRadius: BorderRadius.circular(10)),
//         focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: kGreyColor),
//             borderRadius: BorderRadius.circular(10)),
//       ),
//
//       showSelectedItems: showSelectedItem!,
//       selectedItem: selectedItem,
//       mode: Mode.MENU,//Todo i just changed  Mode.DIALOG to Mode.
//       showSearchBox:false,//Todo i just change  true to false
//       items: items ,
//       itemAsString: (item) => item!,
//       onChanged: (v){
//
//         return onChanged!(v);
//
//       },
//
//     );
//   }
// }





class SearchableDD extends StatelessWidget {

  final String? hintText;
  final TextStyle? hintStyle;
  final String? label;
  final TextStyle? labelStyle;
  final String? selectedItem;
  final List<String> items;
  final Function(String?)? onChanged;
  final String? Function(String?)? validate;
  final bool? showSelectedItem;
  final bool? showClearButton;
  final TextEditingController? controller;

  SearchableDD({
    this.hintText,
    this.hintStyle,
    this.controller,
    this.label,
    this.labelStyle,
    this.selectedItem,
    required this.items,
    this.onChanged,
    this.validate,
    this.showSelectedItem = true,
    this.showClearButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(

        showSelectedItems: showSelectedItem!,
        constraints:BoxConstraints(
          maxHeight: 200,
        ),
        showSearchBox: true,
        fit: FlexFit.tight,

        searchFieldProps: TextFieldProps(
          controller: controller,
          decoration: InputDecoration(


            hintText: hintText,
            hintStyle: hintStyle?? TextStyle(fontSize: 12),
            labelStyle:  TextStyle(fontSize: 12),// Reduced font size
            contentPadding: EdgeInsets.all(5), // Reduced padding
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Reduced border radius
            ),
          ),
        ),
        // searchFieldProps: TextFieldProps(
        //   controller: controller,
        //   decoration: InputDecoration(
        //     hintText: hintText,
        //     hintStyle: hintStyle ?? TextStyle(fontSize: 18, color: Colors.grey),
        //   ),
        // ),


        itemBuilder: (context, item, isSelected) {
          return SizedBox(
            height: 40,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0), // Reduced padding
              title: Text(
                item,
                style: TextStyle(fontSize: 14), // Adjust font size as needed
              ),
            ),
          );
        },
      ),
      dropdownBuilder: (context, String? selectedItem) {
        if (selectedItem == null || selectedItem.isEmpty) {
          return Text(
            hintText ?? "Select items",
            style: TextStyle(color: Colors.black54, fontSize: 14),
          );
        } else {
          return Text(
            selectedItem,
            style: TextStyle(color: Colors.black87, fontSize: 16),
          );
        }
      },


      validator: validate,
      clearButtonProps: showClearButton!
          ? ClearButtonProps(isVisible: true)
          : ClearButtonProps(isVisible: false),
      dropdownDecoratorProps: DropDownDecoratorProps(

        dropdownSearchDecoration: InputDecoration(
          labelStyle: labelStyle ?? TextStyle(fontSize: 18),
          labelText: label,
          hintText: hintText,
          hintStyle: hintStyle ?? TextStyle(fontSize: 18, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      selectedItem: selectedItem,
      items: items,
      itemAsString: (item) => item,
      onChanged: onChanged,
    );
  }
}

















// class MultiLevelDropdown<T> extends StatefulWidget {
//   final String? hintText;
//   final String? label;
//   final bool? filled;
//   final List<T>? items;
//   final Function(List<T>)? onChanged;
//   final List<T>? selectedItem;
//   final Key? dropdownKey;
//
//   MultiLevelDropdown({
//     required this.hintText,
//     required this.label,
//     required this.items,
//     required this.onChanged,
//     this.filled,
//     this.selectedItem,
//     this.dropdownKey,
//   });
//
//   @override
//   _MultiLevelDropdownState<T> createState() => _MultiLevelDropdownState<T>();
// }
//
// class _MultiLevelDropdownState<T> extends State<MultiLevelDropdown<T>> {
//   late List<T> _selectedItems;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedItems = widget.selectedItem ?? [];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownSearch<T>.multiSelection(
//       key: widget.dropdownKey,
//   selectedItems: _selectedItems??[],
//       dropdownDecoratorProps: DropDownDecoratorProps(
//         dropdownSearchDecoration: InputDecoration(
//           labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
//           labelText: widget.label,
//           hintText: widget.hintText,
//           filled: widget.filled,
//
//           hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
//           contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey),
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//       //compareFn: (item, _selectedItems) =>item== _selectedItems,
//
//       popupProps: PopupPropsMultiSelection.menu(
//         //fit: FlexFit.tight,
//         showSelectedItems: true,
//         constraints: BoxConstraints(
//           maxHeight: 150,
//         ),
//         itemBuilder: (context, item, isSelected) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
//             child: Row(
//               children: [
//                 Text(
//                   item.toString(),
//                   style: TextStyle(fontSize: 14),
//                 ),
//
//
//
//               ],
//             ),
//           );
//         },
//         selectionWidget: (context, item, isSelected) {
//          return Padding(
//             padding:const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
//             child: Row(
//
//               children: [
//                 SizedBox(width: 8),
//                 Text(
//                   item.toString(),
//                   style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   width: 24,
//                   height: 24,
//                   child: Checkbox(
//                     value: isSelected,
//                     onChanged: (value) {
//                       setState(() {
//                         if (value == true) {
//                           _selectedItems.add(item);
//                         } else {
//
//                           _selectedItems.remove(item);
//                         }
//                         widget.onChanged!(_selectedItems);
//                       });
//                     },
//                     checkColor: Colors.white,
//                     activeColor: kBlueGrey,
//                   ),
//                 ),
//
//               ],
//             ),
//           );
//         },),
//
//
//
//
//
//
//
//       items: widget.items!,
//       itemAsString: (item) => item.toString(),
//       onChanged: (List<T> selectedItems) {
//         setState(() {
//           _selectedItems = selectedItems;
//         });
//         if (widget.onChanged != null) {
//           widget.onChanged!(_selectedItems);
//         }
//       },
//
//
//
//       dropdownBuilder: (context, List<T> selectedItems) {
//         if (selectedItems.isEmpty) {
//           return Text(
//             widget.hintText ?? "Select items",
//             style: TextStyle(color: Colors.black54, fontSize: 18),
//           );
//         }
//         return SingleChildScrollView(
//           child: Wrap(
//             children: _selectedItems.map((item) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(item.toString()),
//                     if (_selectedItems.last != item) Text(", "),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         );
//
//       },
//     );
//   }
// }



class MultiLevelDropdown<T> extends StatefulWidget {
  final String? hintText;
  final String? label;
  final bool? filled;
  final List<T>? items;
  final Function(List<T>)? onChanged;
  final List<T>? selectedItem;
  final Key? dropdownKey;

  MultiLevelDropdown({
    required this.hintText,
    required this.label,
    required this.items,
    required this.onChanged,
    this.filled,
    this.selectedItem,
    this.dropdownKey,
  });

  @override
  _MultiLevelDropdownState<T> createState() => _MultiLevelDropdownState<T>();
}

class _MultiLevelDropdownState<T> extends State<MultiLevelDropdown<T>> {
  late List<T> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.selectedItem ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>.multiSelection(
      key: widget.dropdownKey,
      selectedItems: _selectedItems ?? [],
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 15,),
          labelText: widget.label,
          hintText: widget.hintText,
          filled: widget.filled,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey),

          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      popupProps: PopupPropsMultiSelection.menu(

        showSearchBox: true,
        fit: FlexFit.tight,

        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(

            hintText: 'Search items',
            hintStyle: TextStyle(fontSize: 12), // Reduced font size
            contentPadding: EdgeInsets.all(5), // Reduced padding
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Reduced border radius
            ),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: 250,
        ),
        itemBuilder: (context, item, isSelected) {
          return SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0), // Reduced vertical padding
              child: ListTile(
            
                  title: Text(
                  item.toString(),
                  style: TextStyle(fontSize: 14), // Reduced font size
                ),
                onTap: () {
                  setState(() {
                    if (_selectedItems.contains(item)) {
                      _selectedItems.remove(item);
                    } else {
                      _selectedItems.add(item);
                    }
                    widget.onChanged!(_selectedItems);
                  });
                },
              ),
            ),
          );
        },
        selectionWidget: (context, item, isSelected) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Reduced horizontal padding
            child: Column(
              children: [
                SizedBox(height: 18,),
                SizedBox(

                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          _selectedItems.add(item);
                        } else {
                          _selectedItems.remove(item);
                        }
                        widget.onChanged!(_selectedItems);
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: kBlueGrey,
                  ),
                ),
              ],
            ),
          );
        },


        // selectionWidget: (context, item, isSelected) {
        //   return Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 16.0), // Reduced horizontal padding
        //     child: SizedBox(
        //       width: 24,
        //       height: 24,
        //       child: Checkbox(
        //         value: isSelected,
        //         onChanged: (value) {
        //           setState(() {
        //             if (value == true) {
        //               _selectedItems.add(item);
        //             } else {
        //               _selectedItems.remove(item);
        //             }
        //             widget.onChanged!(_selectedItems);
        //           });
        //         },
        //         checkColor: Colors.white,
        //         activeColor: kBlueGrey,
        //       ),
        //     ),
        //   );
        // },


      ),
      items: widget.items!,
      itemAsString: (item) => item.toString(),
      onChanged: (List<T> selectedItems) {
        setState(() {
          _selectedItems = selectedItems;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(_selectedItems);
        }
      },
      dropdownBuilder: (context, List<T> selectedItems) {
        if (selectedItems.isEmpty) {
          return Text(
            widget.hintText ?? "Select items",
            style: TextStyle(color: Colors.black54, fontSize: 16),
          );
        }
        return SingleChildScrollView(
          child: Wrap(
            children: _selectedItems.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item.toString(), style: TextStyle(fontSize: 14)), // Reduced font size
                    if (_selectedItems.last != item) Text(", "),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}


//todo-----------------------------------------------------///









// class MultiLevelDropdown<T> extends StatefulWidget {
//   final String? hintText;
//   final String? label;
//   final bool? filled;
//   final List<T>? items;
//   final Function(List<T>)? onChanged;
//   final List<T>? selectedItem;
//   final Key? dropdownKey;
//
//   MultiLevelDropdown({
//     required this.hintText,
//     required this.label,
//     required this.items,
//     required this.onChanged,
//     this.filled,
//     this.selectedItem,
//     this.dropdownKey,
//   });
//
//   @override
//   _MultiLevelDropdownState<T> createState() => _MultiLevelDropdownState<T>();
// }
//
// class _MultiLevelDropdownState<T> extends State<MultiLevelDropdown<T>> {
//   late List<T> _selectedItems;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedItems = widget.selectedItem ?? [];
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownSearch<T>.multiSelection(
//
//       key: widget.dropdownKey,
//       selectedItems: _selectedItems ?? [],
//       dropdownDecoratorProps: DropDownDecoratorProps(
//         dropdownSearchDecoration: InputDecoration(
//           labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
//           labelText: widget.label,
//           hintText: widget.hintText,
//           filled: widget.filled,
//           hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
//           contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey),
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//       popupProps: PopupPropsMultiSelection.menu(
//
//         //showSelectedItems: true,
//         showSearchBox: true,
//         searchFieldProps: TextFieldProps(
//           decoration: InputDecoration(
//             hintText: 'Search items',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//
//         constraints: BoxConstraints(
//           maxHeight: 160,
//         ),
//         itemBuilder: (context, item, isSelected) {
//           return ListTile(
//             title: Text(
//               item.toString(),
//               style: TextStyle(fontSize: 16),
//             ),
//             onTap: () {
//               setState(() {
//                 if (_selectedItems.contains(item)) {
//                   _selectedItems.remove(item);
//                 } else {
//                   _selectedItems.add(item);
//                 }
//                 widget.onChanged!(_selectedItems);
//               });
//             },
//           );
//         },
//         selectionWidget: (context, item, isSelected) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: SizedBox(
//                     width: 24,
//                     height: 24,
//                     child: Checkbox(
//                       value: isSelected,
//                       onChanged: (value) {
//                         setState(() {
//                           if (value == true) {
//                             _selectedItems.add(item);
//                           } else {
//
//                             _selectedItems.remove(item);
//                           }
//                           widget.onChanged!(_selectedItems);
//                         });
//                       },
//                       checkColor: Colors.white,
//                       activeColor: kBlueGrey,
//                     ),
//                   ),
//           );
//         },
//       ),
//       items: widget.items!,
//       itemAsString: (item) => item.toString(),
//       onChanged: (List<T> selectedItems) {
//         setState(() {
//           _selectedItems = selectedItems;
//         });
//         if (widget.onChanged != null) {
//           widget.onChanged!(_selectedItems);
//         }
//       },
//       dropdownBuilder: (context, List<T> selectedItems) {
//
//         if (selectedItems.isEmpty) {
//           return Text(
//             widget.hintText ?? "Select items",
//             style: TextStyle(color: Colors.black54, fontSize: 18),
//           );
//         }
//         return SingleChildScrollView(
//           child: Wrap(
//             children: _selectedItems.map((item) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(item.toString()),
//                     if (_selectedItems.last != item) Text(", "),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }
// }


//todo --------------------------------------------------------------------------------------------------------------


/* this is  search field  dropdown  above searchable dropdown also  work  but  they want  similar  to jobseeker
 that's why i added search Field dropdown(11-06-24 at 12:00)
 */






class SearchFieldwithSingleSelection extends StatelessWidget {
  final String label;
  final List itemList;
  final TextEditingController itemController;
  //final String itemKey;
  final ValueChanged<String> onChanged;

  const  SearchFieldwithSingleSelection({
    Key? key,
    required this.label,
    required this.itemList,
    required this.itemController,
    //required this.itemKey,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: SearchField(

        suggestionState:Suggestion.expand,
        suggestionDirection: SuggestionDirection.down,


        offset: Offset(0, -110),
        searchInputDecoration: InputDecoration(
          border: InputBorder.none,
           labelText: label,

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kGreyColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kGreyColor),
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kGreyColor),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          hintStyle: TextStyle(color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
        ),
         onSuggestionTap: (SearchFieldListItem<String> x) {

            onChanged(x.item!);


          },

        suggestions: itemList
            .map(
              (e) => SearchFieldListItem(
            e.toString(),
            item: e.toString(),
            child: Text(e.toString()),
          ),
        )
            .toList(),
        controller: itemController,
      ),
    );
  }
}










