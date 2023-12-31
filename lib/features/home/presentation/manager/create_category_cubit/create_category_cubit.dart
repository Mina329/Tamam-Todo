import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/usecases/create_category_use_case.dart';

part 'create_category_state.dart';

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
