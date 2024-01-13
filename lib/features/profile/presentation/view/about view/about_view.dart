import 'package:flutter/material.dart';
import 'package:todo/features/profile/presentation/view/about%20view/widgets/about_view_body.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: AboutViewBody(),
    );
  }
}
