import 'package:app_usage/app_usage.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/focus/domain/usecases/get_apps_usage_list_use_case.dart';

part 'get_apps_usage_list_state.dart';

class GetAppsUsageListCubit extends Cubit<GetAppsUsageListState> {
  GetAppsUsageListCubit(this.getAppsUsageListUseCase)
      : super(GetAppsUsageListInitial());
  final GetAppsUsageListUseCase getAppsUsageListUseCase;
  Future<void> getAppsUsageList() async {
    emit(GetAppsUsageListLoading());
    var res = await getAppsUsageListUseCase.execute();
    res.fold(
      (failure) => emit(
        GetAppsUsageListFailure(
          errMessage: failure.message,
        ),
      ),
      (infos) => emit(
        GetAppsUsageListSuccess(
          appInfos: infos,
        ),
      ),
    );
  }
}
