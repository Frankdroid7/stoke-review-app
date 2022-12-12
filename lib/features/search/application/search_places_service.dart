import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';
import 'package:stoke_reviews_app/features/search/data/search_repository_impl.dart';
import 'package:stoke_reviews_app/utils/api_call_enum.dart';

import '../../../utils/app_custom_error.dart';

var searchPlacesStateNotifierProvider =
    StateNotifierProvider<SearchPlacesService, ApiCallEnum>(
        (ref) => SearchPlacesService(ref.read(searchPlacesRepoImpl)));

class SearchPlacesService extends StateNotifier<ApiCallEnum> {
  SearchRepositoryImpl searchRepositoryImpl;
  SearchPlacesService(this.searchRepositoryImpl) : super(ApiCallEnum.idle);

  String errorMessage = '';
  List<PlacesModel> placesModelList = [];

  Future<List<PlacesModel>> searchPlaces(String name) async {
    state = ApiCallEnum.loading;

    searchRepositoryImpl.searchPlaces(name: name).then((value) {
      placesModelList = value;
      state = ApiCallEnum.success;
    }).catchError((err) {
      err as AppCustomError;
      errorMessage = err.error;
      state = ApiCallEnum.error;
    });

    return placesModelList;
  }
}
