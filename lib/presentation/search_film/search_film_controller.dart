import 'package:get/get.dart';
import 'package:tmdb_ek/di/injection.dart';
import 'package:tmdb_ek/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_ek/domain/usecase/get_search_film_uc.dart';
import 'package:tmdb_ek/state/view_state/view_state.dart';

class SearchFilmController extends GetxController {
  final GetSearchFilmUc _searchFilmUc = inject<GetSearchFilmUc>();

  Rx<ViewState<List<FilmEntity>>> searchList =
      const ViewState<List<FilmEntity>>.initial().obs;

  @override
  void onInit() async {
    super.onInit();
    final args = Get.arguments as String?;
    if (args != null) {
      String querry = args;
      searchList.value = const ViewState.loading();
      final result = await _searchFilmUc.call(querry);
      result.when(
        success: (data) {
          searchList.value = ViewState.success(data: data);
        },
        error: (message, data, exception, stackTrace, statusCode) {
          searchList.value = ViewState.error(message: message);
        },
      );
    } else {
      searchList.value = const ViewState.error(message: 'No query found');
    }
  }
}
