import 'package:flutter/material.dart';
import 'package:todo/features/home/presentation/view/widgets/create_category_view_body.dart';

class CreateCategoryView extends StatelessWidget {
  const CreateCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CreateCategoryViewBody(),
    );
  }
}
