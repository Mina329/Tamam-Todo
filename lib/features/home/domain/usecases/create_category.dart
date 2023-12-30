import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/repos/home_repo.dart';

class CreateCategoryUseCase extends UseCase<void, CategoryData> {
  final HomeRepo homeRepo;

  CreateCategoryUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, void>> execute([CategoryData? inputs]) async {
    return await homeRepo.createCategory(inputs!);
  }
}
