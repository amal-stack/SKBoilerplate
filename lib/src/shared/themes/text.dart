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

Widget RichText({
  required List<TextModel> texts,
  int maxLines = 10,
  TextAlign alignment = TextAlign.start,
}) {
  return Text.rich(
    TextSpan(
      children: <TextSpan>[
        for (var text in texts)
          TextSpan(
            recognizer:
                !(text.onTap != null)
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
              decoration:
                  text.isUnderLineRequired == true
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

  TextModel(
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

  static List<TextModel> fromList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.fold<List<TextModel>>(
      [],
      (previousValue, element) => [...previousValue, TextModel(element)],
    );
  }

  @override
  String toString() {
    return 'TextModel(color: $color, text: $text, fontWeight: $fontWeight, alignment: $alignment, size: $size, maxLines: $maxLines, isUnderLineRequired: $isUnderLineRequired)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TextModel &&
        other.color == color &&
        other.text == text &&
        other.fontWeight == fontWeight &&
        other.alignment == alignment &&
        other.size == size &&
        other.isUnderLineRequired == isUnderLineRequired &&
        other.maxLines == maxLines;
  }

  @override
  int get hashCode {
    return color.hashCode ^
        text.hashCode ^
        fontWeight.hashCode ^
        alignment.hashCode ^
        size.hashCode ^
        isUnderLineRequired.hashCode ^
        maxLines.hashCode;
  }
}
