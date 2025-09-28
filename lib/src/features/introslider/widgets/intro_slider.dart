import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/page_data.dart';
import 'action_button.dart';
import 'indicator.dart';
import 'page.dart';

class IntroSlider extends StatefulWidget {
  const IntroSlider({super.key, required this.pages, required this.onFinished});

  final List<IntroSliderPageData> pages;

  final VoidCallback onFinished;

  @override
  State<IntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: PageView.builder(
          controller: _controller,
          itemCount: widget.pages.length,
          itemBuilder: (_, index) => IntroSliderPage(page: widget.pages[index]),
        ),
      ),
      IntroSliderPageIndicator(
        controller: _controller,
        length: widget.pages.length,
      ),
      SizedBox(height: 30.h),
      IntroSliderActionButton(
        controller: _controller,
        length: widget.pages.length,
        onFinished: widget.onFinished,
      ),
      SizedBox(height: 50.h),
    ],
  );
}

