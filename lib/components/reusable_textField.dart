import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/utils/color_constants.dart';

class ReusableTextField extends StatelessWidget {
  //final Function? validate;

  final TextInputType? keyboardType;
  final String? labelText;
  final String? initialValue;
  final String? hintText;

  final int? maxlength;
  final  int? limitnum;
  final String? Function(String?)? validate; // Change type to accept String argument
  final Function(String)? onChanged;
  final TextEditingController? controller; // Add controller property
  final bool readOnly; // Add a boolean parameter for readonly
  final Key? key;
  final TextStyle? textStyle; // Add textStyle parameter
  final TextStyle? labelStyle; // Add hintStyle parameter
  ReusableTextField(
      {this.hintText,
      this.onChanged,
      this.initialValue,
      this.labelText,
      this.keyboardType,
      this.validate,
      this.maxlength,
        this.limitnum,
        this.controller,
        this.readOnly = false, // Set default value to false
      this.key,
      this.textStyle,
        this.labelStyle,

      });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      key: key,
      maxLength: maxlength,
      inputFormatters: [LengthLimitingTextInputFormatter(limitnum)],
      initialValue: initialValue,
      onChanged: (v)=> onChanged!(v),
      validator: validate, // Pass the validate function directly
      // validator: (v){
      //   validate!();
      // },
      keyboardType: keyboardType,
      style:textStyle?? TextStyle(fontSize: 14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        hintText: hintText,
        labelText: labelText,
        labelStyle: labelStyle,

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
