import 'package:flutter/material.dart';
import 'package:todo/features/auth/presentation/view/email%20verify%20view/widgets/email_verify_view_body.dart';

class EmailVerifyView extends StatelessWidget {
  const EmailVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EmailVerifyBody(),
    );
  }
}
