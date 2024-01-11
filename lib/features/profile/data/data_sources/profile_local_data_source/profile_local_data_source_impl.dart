import 'package:todo/core/cache/cache_helper.dart';
import 'package:todo/core/cache/cache_keys_values.dart';
import 'package:todo/core/database/database.dart';
import 'package:todo/features/profile/data/data_sources/profile_local_data_source/profile_local_data_source.dart';

class ProfileLocalDataSourceImpl extends ProfileLocalDataSource {
  @override
  Future<void> deleteAccount() async {
    clearDataBase();
    await CacheData.removeData(key: CacheKeys.kDATE);
    await CacheData.removeData(key: CacheKeys.kSECONDS);
  }
}
