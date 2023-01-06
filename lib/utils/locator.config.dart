// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:jojo/services/api/config.api.dart' as _i3;
import 'package:jojo/services/api/delivery.api.dart' as _i4;
import 'package:jojo/services/api/user.api.dart' as _i6;
import 'package:jojo/services/hive/hive_service.dart' as _i5;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.ConfigApi>(() => _i3.ConfigApi());
    gh.lazySingleton<_i4.DeliveryApi>(() => _i4.DeliveryApi());
    gh.lazySingleton<_i5.HiveService>(() => _i5.HiveService());
    gh.lazySingleton<_i6.UserApi>(() => _i6.UserApi());
    return this;
  }
}
