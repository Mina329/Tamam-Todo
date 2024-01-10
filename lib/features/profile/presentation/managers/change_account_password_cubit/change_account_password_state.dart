part of 'change_account_password_cubit.dart';

@immutable
sealed class ChangeAccountPasswordState {}

final class ChangeAccountPasswordInitial extends ChangeAccountPasswordState {}

final class ChangeAccountPasswordLoading extends ChangeAccountPasswordState {}

final class ChangeAccountPasswordSuccess extends ChangeAccountPasswordState {}

final class ChangeAccountPasswordFailure extends ChangeAccountPasswordState {
  final String errMessage;

  ChangeAccountPasswordFailure({required this.errMessage});
}
