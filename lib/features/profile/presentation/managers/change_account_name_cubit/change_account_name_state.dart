part of 'change_account_name_cubit.dart';

@immutable
sealed class ChangeAccountNameState {}

final class ChangeAccountNameInitial extends ChangeAccountNameState {}

final class ChangeAccountNameLoading extends ChangeAccountNameState {}

final class ChangeAccountNameFailure extends ChangeAccountNameState {
  final String errMessage;

  ChangeAccountNameFailure({required this.errMessage});
}

final class ChangeAccountNameSuccess extends ChangeAccountNameState {}
