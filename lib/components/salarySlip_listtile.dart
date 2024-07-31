import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/utils/color_constants.dart';

class SalarySlipListtile extends StatelessWidget {
  final String? title;
  final String? initialValue;
  final Function(dynamic)? onChnaged;

  const SalarySlipListtile(
      {Key? key, this.title, this.onChnaged, this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title!,style:TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)),

          Container(
            color: Colors.transparent,
            width: 120,
            height: 40,
            child: TextFormField(

              initialValue: initialValue,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              LengthLimitingTextInputFormatter(8),
              ],
              onChanged: (v)=> onChnaged!(v),
              style: TextStyle(fontSize: 14),
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: kGreyColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: kGreyColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: kGreyColor),
                  ),
                  prefixText: '₹',
                  hintText: 'in rupees'


              ),

            ),
          )
        ],
      ),
    );
  }
}
























//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:manago_employer/utils/color_constants.dart';
//
// class SalarySlipListtile extends StatefulWidget {
//   final String? title;
//   final String? initialValue;
//   final Function(dynamic)? onChnaged;
//
//   const SalarySlipListtile({
//     Key? key,
//     this.title,
//     this.onChnaged,
//     this.initialValue,
//   }) : super(key: key);
//
//   @override
//   _SalarySlipListtileState createState() => _SalarySlipListtileState();
// }
//
// class _SalarySlipListtileState extends State<SalarySlipListtile> {
//   late TextEditingController _controller;
//   late FocusNode _focusNode;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController(text: widget.initialValue);
//     _focusNode = FocusNode();
//   }
//
//   @override
//   void didUpdateWidget(SalarySlipListtile oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.initialValue != widget.initialValue) {
//       _controller.text = widget.initialValue ?? '';
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Text(
//               widget.title ?? '',
//               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//             ),
//           ),
//           Container(
//             color: Colors.transparent,
//             width: 120,
//             height: 40,
//             child: TextFormField(
//               controller: _controller,
//               focusNode: _focusNode,
//               keyboardType: TextInputType.number,
//               inputFormatters: [
//                 FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                 LengthLimitingTextInputFormatter(8),
//               ],
//               onChanged: (v) => widget.onChnaged?.call(v),
//               style: TextStyle(fontSize: 14),
//               textAlignVertical: TextAlignVertical.bottom,
//               decoration: InputDecoration(
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: BorderSide(color: kGreyColor),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: BorderSide(color: kGreyColor),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: BorderSide(color: kGreyColor),
//                 ),
//                 hintText: 'in rupees',
//               ),
//               onTap: () {
//                 // Additional handling when the field is tapped
//                 _focusNode.requestFocus();
//                 _controller.selection = TextSelection.fromPosition(
//                     TextPosition(offset: _controller.text.length));
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
