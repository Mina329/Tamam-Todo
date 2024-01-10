import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/profile/domain/repos/profile_repo.dart';

class ChangeAccountPhotoUseCase extends UseCase<void, File> {
  final ProfileRepo profileRepo;

  ChangeAccountPhotoUseCase({required this.profileRepo});

  @override
  Future<Either<Failure, void>> execute([File? inputs]) async {
    return await profileRepo.changeAccountPhoto(inputs!);
  }
}
