import 'package:dartz/dartz.dart';
import 'package:tamam_account_delete/core/failure.dart';
import 'package:tamam_account_delete/core/use_case.dart';
import 'package:tamam_account_delete/domain/repos/home_repo.dart';

class DeleteAccountWithGoogleUseCase extends UseCase<void, void> {
  final HomeRepo homeRepo;

  DeleteAccountWithGoogleUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, void>> execute([void inputs]) async {
    return await homeRepo.deleteAccountWithGoogle();
  }
}
