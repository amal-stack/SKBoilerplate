import 'package:flutter/material.dart';

import '../widgets/auth_scaffold.dart';
import '../widgets/success_body.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const AuthScaffold(child: SuccessBody());
}
