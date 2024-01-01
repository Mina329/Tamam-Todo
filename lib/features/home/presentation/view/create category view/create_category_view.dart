import 'package:flutter/material.dart';
import 'package:todo/features/home/presentation/view/create%20category%20view/widgets/create_category_view_body.dart';

class CreateCategoryView extends StatelessWidget {
  const CreateCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: CreateCategoryViewBody(),
    );
  }
}
