import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';

class SalaryRangeSelector extends StatefulWidget {
  final double? minSalary;
  final double? maxSalary;
  final RangeValues? initialValues;
  final void Function(RangeValues)? onRangeChanged;

  const SalaryRangeSelector({
    Key? key,
    @required this.minSalary,
    @required this.maxSalary,
    @required this.initialValues,
    @required this.onRangeChanged,
  }) : super(key: key);

  @override
  _SalaryRangeSelectorState createState() => _SalaryRangeSelectorState();
}

class _SalaryRangeSelectorState extends State<SalaryRangeSelector> {
  RangeValues? _values;

  @override
  void initState() {
    super.initState();
    _values = widget.initialValues;
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbColor: Colors.white,
        activeTrackColor: kBlueGrey,
        inactiveTrackColor: Colors.grey[400],
        overlayColor: kBlueGrey.withOpacity(0.3),
        rangeThumbShape: CustomRangeSliderThumbShape(
          thumbRadius: 8,
          thumbColor: Colors.white,
          thumbBorderColor: kBlueGrey,
          thumbHeight: 2,
        ),
        trackHeight: 2,
      ),
      child: Stack(
        children: [
          RangeSlider(
            values: _values!,
            min: widget.minSalary!,
            max: widget.maxSalary!,
            onChanged: (values) {
              setState(() {
                _values = values;
              });
              widget.onRangeChanged!(values);
            },
            labels: RangeLabels(
              _values!.start.toStringAsFixed(0),
              _values!.end.toStringAsFixed(0),
            ),
            semanticFormatterCallback: (double value) =>
                '${value.round().toString()}',
          ),
          Positioned(
            left: _values!.start /
                    widget.maxSalary! *
                    MediaQuery.of(context).size.width -
                40,
            top: 36,
            child: Text('${_values!.start.toStringAsFixed(0)}k',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
          ),
          Positioned(
            right: (widget.maxSalary! - _values!.end) /
                    widget.maxSalary! *
                    MediaQuery.of(context).size.width -
                40,
            top: 36,
            child: Text('${_values!.end.toStringAsFixed(0)}k',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class CustomRangeSliderThumbShape extends RangeSliderThumbShape {
  final double? thumbRadius;
  final double? thumbHeight;
  final Color? thumbColor;
  final Color? thumbBorderColor;

  const CustomRangeSliderThumbShape({
    @required this.thumbRadius,
    @required this.thumbHeight,
    @required this.thumbColor,
    @required this.thumbBorderColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius!);
  }

  @override
  void paint(
    PaintingContext context,
    Offset thumbCenter, {
    @required Animation<double>? activationAnimation,
    @required Animation<double>? enableAnimation,
    @required bool? isDiscrete,
    @required bool? isEnabled,
    @required bool? isOnTop,
    @required bool? isPressed,
    @required SliderThemeData? sliderTheme,
    @required TextDirection? textDirection,
    @required Thumb? thumb,
  }) {
    final Canvas canvas = context.canvas;

    final Paint paint = Paint()
      ..color = thumbColor!
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = thumbBorderColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(thumbCenter, thumbRadius!, paint);
    canvas.drawCircle(thumbCenter, thumbRadius!, borderPaint);
  }
}
