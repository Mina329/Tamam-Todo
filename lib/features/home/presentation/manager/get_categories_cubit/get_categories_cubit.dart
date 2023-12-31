import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/usecases/get_all_categories_use_case.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit(this.getAllCategoriesUseCase)
      : super(GetCategoriesInitial());
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  Future<void> getAllCategories() async {
    emit(GetCategoriesLoading());
    var result = await getAllCategoriesUseCase.execute();
    result.fold(
      (failure) => emit(
        GetCategoriesFailure(errMessage: failure.message),
      ),
      (categories) => emit(
        GetCategoriesSucecess(categories: categories),
      ),
    );
  }
}
