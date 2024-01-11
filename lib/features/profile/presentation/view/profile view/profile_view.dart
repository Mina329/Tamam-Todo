import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/utils/service_locator.dart';
import 'package:todo/features/profile/domain/usecases/delete_account_use_case.dart';
import 'package:todo/features/profile/presentation/managers/delete_account_cubit/delete_account_cubit.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteAccountCubit(
        getIt.get<DeleteAccountUseCase>(),
      ),
      child: const ProfileViewBody(),
    );
  }
}
