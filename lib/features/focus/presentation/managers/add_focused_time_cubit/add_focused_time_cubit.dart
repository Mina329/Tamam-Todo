import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/focus/domain/usecases/add_time_for_today_use_case.dart';

part 'add_focused_time_state.dart';

class AddFocusedTimeCubit extends Cubit<AddFocusedTimeState> {
  AddFocusedTimeCubit(this.addTimeForTodayUseCase)
      : super(AddFocusedTimeInitial());
  final AddTimeForTodayUseCase addTimeForTodayUseCase;

  Future<void> addFocusedTime(int seconds) async {
    emit(AddFocusedTimeLoading());
    var result = await addTimeForTodayUseCase.execute(seconds);
    result.fold(
      (failure) => emit(
        AddFocusedTimeFailure(
          errMessage: failure.message,
        ),
      ),
      (success) => emit(
        AddFocusedTimeSuccess(),
      ),
    );
  }
}
