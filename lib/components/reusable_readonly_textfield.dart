import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/utils/color_constants.dart';

class ReusableReadonlyTextField extends StatelessWidget {

  final String? hintText;
  final String? labelText;
  final Function(dynamic)? onChanged;
  final String? initialValue;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final Color? textColor;
  final Pattern? pattern;
  final String? Function(String?)? validator; // Added validator function
  final TextEditingController? controller; // Added controller
 final  int? linum;

  ReusableReadonlyTextField(
      {this.hintText,
      this.onChanged,
      this.initialValue,
      this.readOnly = false,
      this.labelText,
      this.keyboardType,
      this.textColor,
      this.pattern,
        this.validator,
        this.controller,
        this.linum,

      });
  @override
  Widget build(BuildContext context) {

    return TextFormField(

      validator: validator, // Set the validator function
      //inputFormatters: pattern != null ? [FilteringTextInputFormatter.allow(RegExp(pattern!))] : null,
      // validator: (value) {
      //   if (value != null && value.isNotEmpty) {
      //     if (pattern != null && !(pattern as RegExp).hasMatch(value)) {
      //       return 'Please enter a valid $labelText URL';
      //     }
      //   }
      //   return null;
      // },
      inputFormatters: [
        if (pattern != null) FilteringTextInputFormatter.allow(pattern!),
        if (linum != null) LengthLimitingTextInputFormatter(linum),
        // FilteringTextInputFormatter.allow(pattern??r'.*'),
        // LengthLimitingTextInputFormatter(linum)
      ],

      controller: controller,
      initialValue: initialValue,
      onChanged: (v)=> onChanged!(v),
      readOnly: readOnly!,
      style: TextStyle(fontSize: 18, color: textColor ?? Colors.black),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(color: textColor ?? Colors.black),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kGreyColor),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kGreyColor),
            borderRadius: BorderRadius.circular(10)),

      ),

    );
  }
}
