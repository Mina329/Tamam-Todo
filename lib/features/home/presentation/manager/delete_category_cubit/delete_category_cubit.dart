import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/home/domain/usecases/delete_category_use_case.dart';

part 'delete_category_state.dart';

class DeleteCategoryCubit extends Cubit<DeleteCategoryState> {
  DeleteCategoryCubit(this.deleteCategoryUseCase)
      : super(DeleteCategoryInitial());
  final DeleteCategoryUseCase deleteCategoryUseCase;
  Future<void> deleteCategory(String categoryId) async {
    emit(DeleteCategoryLoading());
    var result = await deleteCategoryUseCase.execute(categoryId);
    result.fold(
      (failure) => emit(
        DeleteCategoryFailure(errMessage: failure.message),
      ),
      (success) => emit(
        DeleteCategorySuccess(id: categoryId),
      ),
    );
  }
}
