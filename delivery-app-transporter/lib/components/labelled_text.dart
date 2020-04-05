import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabelledText extends StatelessWidget{
  final Text label;
  final Widget value;
  final double spaceBetween;
  final EdgeInsets padding;

  const LabelledText({Key key, @required this.label, @required this.value, this.spaceBetween=10, this.padding=const EdgeInsets.only(left: 20)}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(direction: Axis.vertical,children: <Widget>[
      label,
      SizedBox(height: spaceBetween,),
      Padding(padding: padding,child: value,)
    ],);
  }

}