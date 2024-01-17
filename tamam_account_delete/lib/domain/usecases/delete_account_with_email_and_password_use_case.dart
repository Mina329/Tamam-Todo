import 'package:dartz/dartz.dart';
import 'package:tamam_account_delete/core/failure.dart';
import 'package:tamam_account_delete/core/use_case.dart';
import 'package:tamam_account_delete/domain/repos/home_repo.dart';

class DeleteAccountWithEmailAndPasswordUseCase
    extends UseCase<void, (String, String)> {
  final HomeRepo homeRepo;

  DeleteAccountWithEmailAndPasswordUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, void>> execute([(String, String)? inputs]) async {
    return await homeRepo.deleteAccountWithEmailAndPassword(
        inputs!.$1, inputs.$2);
  }
}
