import 'package:boilerplate/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField({
    super.key,
    required this.label,
    required this.onChanged,
    this.controller,
  });

  final String label;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) => InputTextField(
    label: label,
    hintMessage: label,
    controller: controller,
    prefixIcon: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/images/search.png", width: 20.w, height: 20.h),
      ],
    ),
    onChanged: onChanged,
  );
}
