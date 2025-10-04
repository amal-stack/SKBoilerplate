import 'package:flutter/material.dart';

@immutable
class IntroSliderPageData {
  const IntroSliderPageData({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
  });

  final String imageAsset;
  final String title;
  final String subtitle;
}
