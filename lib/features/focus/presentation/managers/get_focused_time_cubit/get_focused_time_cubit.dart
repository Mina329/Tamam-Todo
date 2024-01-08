import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/focus/domain/usecases/get_focused_time_use_case.dart';

part 'get_focused_time_state.dart';

class GetFocusedTimeCubit extends Cubit<GetFocusedTimeState> {
  GetFocusedTimeCubit(this.getFocusedTimeUseCase)
      : super(GetFocusedTimeInitial());
  final GetFocusedTimeUseCase getFocusedTimeUseCase;
  Future<void> getFocusedTime() async {
    emit(GetFocusedTimeLoading());
    var result = await getFocusedTimeUseCase.execute();
    result.fold(
      (failure) => emit(
        GetFocusedTimeFailure(
          errMessage: failure.message,
        ),
      ),
      (seconds) => emit(
        GetFocusedTimeSuccess(
          seconds: seconds,
        ),
      ),
    );
  }
}
