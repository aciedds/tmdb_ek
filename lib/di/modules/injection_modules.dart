import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_ek/utils/dio_utils.dart';
import 'package:tmdb_ek/utils/hive_utils.dart';

@module
abstract class InjectionModules {
  @lazySingleton
  @preResolve
  Future<HiveUtils> get hive async => HiveUtils.instance();

  @lazySingleton
  @preResolve
  Future<Dio> get client async => DioUtils.client();
}
