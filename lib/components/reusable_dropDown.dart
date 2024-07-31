import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';

class ReusableDropDown extends StatelessWidget {
  final Function? validate;
  final String? hintText;
  final String? value;
  final List<String>? options;
  final Function(dynamic)? onChanged;

  ReusableDropDown({
    this.hintText,
    this.value,
    this.options,
    this.onChanged,
    this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: kGreyColor,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          
          menuMaxHeight: 200,
          hint: Text(hintText!,style: TextStyle(fontSize: 18),),
          isExpanded:true,

          value: value,
          onChanged: (v) => onChanged!(v),
          items: options!
              .map(
                (data) => DropdownMenuItem(

              value: data,
              child: Text(data),
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}







class DropdownField extends StatefulWidget {
  final List<String>? options;
  final String? initialValue;
  final String? label;
  final String? labeltext;
  final void Function(String)? onChanged;

  const DropdownField({
    Key? key,
    @required this.options,
    @required this.onChanged,
    this.labeltext,
    this.initialValue ='',
    @required this.label,
  }) : super(key: key);

  @override
  _DropdownFieldState createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialValue != null && widget.initialValue!.isNotEmpty
        ? widget.initialValue
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kGreyColor),
        color: Colors.white,
      ),
      child: DropdownButtonFormField<String>(

        hint: Text(widget.label!),
        value: _selectedOption,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _selectedOption = value;
            });
            widget.onChanged!(value);
          }
        },
        style: TextStyle(
          fontSize: 12,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
        ),
        items: widget.options!
            .map((option) => DropdownMenuItem(
          value: option,
          child: Text(
            option,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ))
            .toList(),
        decoration: InputDecoration(

          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
