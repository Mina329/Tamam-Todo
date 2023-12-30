import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/repos/home_repo.dart';

class GetAllCategoriesUseCase extends UseCase<List<CategoryData>, void> {
  final HomeRepo homeRepo;

  GetAllCategoriesUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, List<CategoryData>>> execute([void inputs]) async {
    return await homeRepo.getAllCategories();
  }
}
