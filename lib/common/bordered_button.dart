import 'package:fixit/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'color_constants.dart';


// ignore: must_be_immutable
class BorderedButton extends StatelessWidget {
  double ? width;
  String text;
  final BorderRadiusGeometry? borderRadius;
  final bool  isReversed;
  final String ? icon;
  BorderedButton({Key? key, required this.width, required this.text,this.borderRadius,this.isReversed=false,this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(minWidth: 89.w),
          padding: EdgeInsets.symmetric(vertical: 2.2.h,),
          decoration: BoxDecoration(
              color:isReversed?Theme.of(context).colorScheme.primary: Theme.of(context).colorScheme.secondary,
              border: Border.all(color: isReversed?Theme.of(context).colorScheme.primary: Theme.of(context).colorScheme.secondary, width: 1.5),
              borderRadius: borderRadius ?? getCustomBorderRadius(13)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child:icon==null?addText(text, getSubheadingTextFontSIze(), isReversed? ColorConstants.white:Theme.of(context).colorScheme.primary, FontWeight.w500,fontFamily: 'Aeonik'):
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(icon!),
                  SizedBox(width: 2.w,),
                  addText(text,getSubheadingTextFontSIze(), isReversed? ColorConstants.white:Theme.of(context).colorScheme.primary, FontWeight.normal,)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
