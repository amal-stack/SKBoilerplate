import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class RegularText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final int? maxLines;
  final double? textSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final double? lineHeight;
  final double? height;

  const RegularText({
    required this.text,
    this.textAlign = TextAlign.start,
    this.textOverflow = TextOverflow.visible,
    this.maxLines,
    this.textSize,
    this.fontWeight,
    this.lineHeight,
    this.textColor,
    this.height = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: maxLines,
      softWrap: true,
      style: TextStyle(
        color: textColor ?? AppColors.primary,
        fontSize: textSize ?? 18.sp,
        fontWeight: fontWeight,
        height: height,
        fontFamily: "Modelica",
      ),
      textAlign: textAlign,
    );
  }
}

class RichText extends StatelessWidget {
  const RichText({
    super.key,
    required this.texts,
    this.maxLines = 10,
    this.alignment = TextAlign.start,
  });

  final List<TextModel> texts;

  final TextAlign alignment;

  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          for (var text in texts)
            TextSpan(
              recognizer: !(text.onTap != null)
                  ? null
                  : (TapGestureRecognizer()
                      ..onTap = () async {
                        if (text.onTap != null) {
                          text.onTap!();

                          return;
                        }
                      }),

              text: text.formattedText,
              style: GoogleFonts.montserrat(
                color: text.color ?? texts.first.color,
                decoration: text.isUnderLineRequired == true
                    ? TextDecoration.underline
                    : TextDecoration.none,
                decorationColor: text.color ?? texts.first.color,
                decorationThickness: 2,
                fontWeight: text.fontWeight ?? texts.first.fontWeight,
                fontSize: text.size ?? texts.first.size,
                // fontFamily: "ProximaNovaExcn"
              ),
            ),
        ],
      ),
      textAlign: alignment,
      maxLines: maxLines,
    );
  }
}

@immutable
class TextModel {
  final Color? color;
  final String text;
  final FontWeight? fontWeight;
  final TextAlign? alignment;
  final double? size;
  final int? maxLines;
  final String? format;
  final VoidCallback? onTap;
  final bool isUnderLineRequired;

  String get formattedText => text;

  const TextModel(
    this.text, {
    this.format,
    this.color = const Color(0xff2e2e2e),
    this.fontWeight = FontWeight.w400,
    this.alignment = TextAlign.start,
    this.size = 14.0,
    this.maxLines = 1,
    this.isUnderLineRequired = false,
    this.onTap,
  });

  static List<TextModel> fromList(List? data) => 
   data == null || data.isEmpty ? const [] : [
      for (var element in data) TextModel(element),
   ];
    

  @override
  String toString() {
    return 'TextModel(color: $color, text: $text, fontWeight: $fontWeight, alignment: $alignment, size: $size, maxLines: $maxLines, isUnderLineRequired: $isUnderLineRequired)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextModel &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          text == other.text &&
          fontWeight == other.fontWeight &&
          alignment == other.alignment &&
          size == other.size &&
          maxLines == other.maxLines &&
          isUnderLineRequired == other.isUnderLineRequired;

  @override
  int get hashCode => Object.hash(
    color,
    text,
    fontWeight,
    alignment,
    size,
    maxLines,
    isUnderLineRequired,
  );
}
