import 'package:bloc/bloc.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/usecases/create_category_use_case.dart';
import 'package:todo/features/home/presentation/manager/create_category_cubit/create_category_cubit.dart';


class CreateCategoryCubit extends Cubit<CreateCategoryState> {
  CreateCategoryCubit(this.createCategoryUseCase)
      : super(CreateCategoryInitial());
  final CreateCategoryUseCase createCategoryUseCase;
  Future<void> createCategory(CategoryEntity category) async {
    emit(CreateCategoryLoading());
    var result = await createCategoryUseCase.execute(category);
    result.fold(
      (failure) => emit(
        CreateCategoryFailure(errMessage: failure.message),
      ),
      (success) => emit(
        CreateCategorySuccess(),
      ),
    );
  }
}
