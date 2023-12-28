import 'package:flutter/material.dart';
import 'package:todo/features/auth/presentation/view/auth%20view/widgets/auth_view_body.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: AuthViewBody(),
      ),
    );
  }
}
