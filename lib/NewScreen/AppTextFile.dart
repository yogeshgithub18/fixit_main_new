import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../common/color_constants.dart';

class AppTexts extends StatelessWidget {
  final String titleText;
  final Color? textColor;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;

  const AppTexts(
      this.titleText, {
        super.key,
        this.textColor,
        this.style,
        this.maxLines,
        this.overflow,
        this.fontWeight,
        this.fontSize,
        this.textAlign,
      });

  const AppTexts.helveticaText16W500(
      this.titleText, {
        super.key,
        this.textColor,
        this.style = const TextStyle(
          fontFamily: 'Helvetica Neue',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w500,
        this.fontSize = 16,
        this.textAlign,
      });

  const AppTexts.helveticaText16W400(
      this.titleText, {
        super.key,
        this.textColor = ColorConstants.black,
        this.style = const TextStyle(
          fontFamily: 'Helvetica Neue',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w400,
        this.fontSize = 16,
        this.textAlign,
      });

  const AppTexts.helveticaText16W600(
      this.titleText, {
        super.key,
        this.textColor = ColorConstants.black,
        this.style = const TextStyle(
          fontFamily: 'Helvetica Neue',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w600,
        this.fontSize = 16,
        this.textAlign,
        }
      );
  const AppTexts.aeonikText13W400(
      this.titleText, {
        super.key,
        this.textColor = ColorConstants.black,
        this.style = const TextStyle(
          fontFamily: 'Aeonik',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w400,
        this.fontSize = 13,
        this.textAlign,
      });

  const AppTexts.aeonikText16W500(
      this.titleText, {
        super.key,
        this.textColor = ColorConstants.black,
        this.style = const TextStyle(
          fontFamily: 'Aeonik',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w500,
        this.fontSize = 16,
        this.textAlign,
      });

  const AppTexts.aeonikText14W400(
      this.titleText, {
        super.key,
        this.textColor = ColorConstants.black,
        this.style = const TextStyle(
          fontFamily: 'Aeonik',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w400,
        this.fontSize = 14,
        this.textAlign,
      });

  const AppTexts.aeonikText16W400(
      this.titleText, {
        super.key,
        this.textColor = ColorConstants.black,
        this.style = const TextStyle(
          fontFamily: 'Aeonik',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w400,
        this.fontSize = 16,
        this.textAlign,
      });

  const AppTexts.helveticaText15W400(
      this.titleText, {
        super.key,
        this.textColor = ColorConstants.fixitAddress,
        this.style = const TextStyle(
          fontFamily: 'Helvetica Neue',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w400,
        this.fontSize = 15,
        this.textAlign,
      });

  const AppTexts.helveticaText16W800(
      this.titleText, {
        super.key,
        this.textColor = ColorConstants.primaryColor,
        this.style = const TextStyle(
          fontFamily: 'Helvetica Neue',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w800,
        this.fontSize = 16,
        this.textAlign,
      });

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style?.copyWith(
      color: textColor ?? ColorConstants.black,
      fontWeight: fontWeight ?? style?.fontWeight,
      fontSize: fontSize ?? style?.fontSize,
    ) ?? TextStyle(
      color: textColor ?? ColorConstants.black,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );

    return Text(
      titleText.tr,
      style: effectiveStyle,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
