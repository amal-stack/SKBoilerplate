import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary.withOpacity(0.95),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.wifi_off, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'No internet connection',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
