// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:tmdb_ek/data/repository/film_repository_impl.dart' as _i656;
import 'package:tmdb_ek/data/repository/source/film_local.dart' as _i41;
import 'package:tmdb_ek/data/repository/source/film_remote.dart' as _i589;
import 'package:tmdb_ek/di/modules/injection_modules.dart' as _i170;
import 'package:tmdb_ek/domain/mapper/film_mapper.dart' as _i436;
import 'package:tmdb_ek/domain/mapper/genre_mapper.dart' as _i638;
import 'package:tmdb_ek/domain/repository/film_repository.dart' as _i1042;
import 'package:tmdb_ek/domain/usecase/add_favorite_uc.dart' as _i220;
import 'package:tmdb_ek/domain/usecase/add_watchlist_uc.dart' as _i76;
import 'package:tmdb_ek/domain/usecase/get_favorite_uc.dart' as _i856;
import 'package:tmdb_ek/domain/usecase/get_has_exist_in_favorite_uc.dart'
    as _i148;
import 'package:tmdb_ek/domain/usecase/get_has_exist_in_watchlist_uc.dart'
    as _i71;
import 'package:tmdb_ek/domain/usecase/get_movie_genres_uc.dart' as _i394;
import 'package:tmdb_ek/domain/usecase/get_now_playing_uc.dart' as _i643;
import 'package:tmdb_ek/domain/usecase/get_popular_film_uc.dart' as _i76;
import 'package:tmdb_ek/domain/usecase/get_search_film_uc.dart' as _i848;
import 'package:tmdb_ek/domain/usecase/get_similar_film_by_genre_ids_uc.dart'
    as _i228;
import 'package:tmdb_ek/domain/usecase/get_similar_film_uc.dart' as _i326;
import 'package:tmdb_ek/domain/usecase/get_watchlist_uc.dart' as _i720;
import 'package:tmdb_ek/domain/usecase/remove_from_favorite_uc.dart' as _i752;
import 'package:tmdb_ek/domain/usecase/remove_from_watchlist_uc.dart' as _i194;
import 'package:tmdb_ek/utils/hive_utils.dart' as _i73;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModules = _$InjectionModules();
    gh.factory<_i436.FilmMapper>(() => _i436.FilmMapper());
    gh.factory<_i638.GenreMapper>(() => _i638.GenreMapper());
    await gh.lazySingletonAsync<_i73.HiveUtils>(
      () => injectionModules.hive,
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i361.Dio>(
      () => injectionModules.client,
      preResolve: true,
    );
    gh.lazySingleton<_i41.FilmLocal>(
        () => _i41.FilmLocal(gh<_i73.HiveUtils>()));
    gh.lazySingleton<_i589.FilmRemote>(() => _i589.FilmRemote(gh<_i361.Dio>()));
    gh.lazySingleton<_i1042.FilmRepository>(() => _i656.FilmRepositoryImpl(
          gh<_i589.FilmRemote>(),
          gh<_i41.FilmLocal>(),
          gh<_i436.FilmMapper>(),
          gh<_i638.GenreMapper>(),
        ));
    gh.factory<_i643.GetNowPlayingUc>(
        () => _i643.GetNowPlayingUc(gh<_i1042.FilmRepository>()));
    gh.factory<_i76.GetPopularFilmUc>(
        () => _i76.GetPopularFilmUc(gh<_i1042.FilmRepository>()));
    gh.factory<_i856.GetFavoriteUc>(
        () => _i856.GetFavoriteUc(gh<_i1042.FilmRepository>()));
    gh.factory<_i71.GetHasExistInWatchlistUc>(
        () => _i71.GetHasExistInWatchlistUc(gh<_i1042.FilmRepository>()));
    gh.factory<_i720.GetWatchlistUc>(
        () => _i720.GetWatchlistUc(gh<_i1042.FilmRepository>()));
    gh.factory<_i76.AddWatchlistUc>(
        () => _i76.AddWatchlistUc(gh<_i1042.FilmRepository>()));
    gh.factory<_i220.AddFavoriteUc>(
        () => _i220.AddFavoriteUc(gh<_i1042.FilmRepository>()));
    gh.factory<_i326.GetSimilarFilmUc>(
        () => _i326.GetSimilarFilmUc(gh<_i1042.FilmRepository>()));
    gh.factory<_i228.GetSimilarFilmByGenresUc>(
        () => _i228.GetSimilarFilmByGenresUc(gh<_i1042.FilmRepository>()));
    gh.factory<_i148.GetHasExistInFavoriteUc>(
        () => _i148.GetHasExistInFavoriteUc(gh<_i1042.FilmRepository>()));
    gh.factory<_i394.GetMovieGenresUc>(
        () => _i394.GetMovieGenresUc(gh<_i1042.FilmRepository>()));
    gh.factory<_i194.RemoveFromWatchlistUc>(
        () => _i194.RemoveFromWatchlistUc(gh<_i1042.FilmRepository>()));
    gh.factory<_i752.RemoveFromFavoriteUc>(
        () => _i752.RemoveFromFavoriteUc(gh<_i1042.FilmRepository>()));
    gh.factory<_i848.GetSearchFilmUc>(
        () => _i848.GetSearchFilmUc(gh<_i1042.FilmRepository>()));
    return this;
  }
}

class _$InjectionModules extends _i170.InjectionModules {}
