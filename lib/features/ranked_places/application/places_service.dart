import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';

import '../../../utils/api_call_enum.dart';
import '../data/places_repo_impl.dart';

var placesServiceStateProvider =
    StateProvider((ref) => PlacesServiceNotifier(ref.read(placesRepoImpl)));

var getAllPlacesFutureProvider =
    FutureProvider.autoDispose<List<PlacesModel>>((ref) {
  return ref.read(placesServiceStateProvider).getAllPlaces();
});

class PlacesServiceNotifier extends StateNotifier<ApiCallEnum> {
  PlacesRepositoryImpl placesRepositoryImpl;
  PlacesServiceNotifier(this.placesRepositoryImpl) : super(ApiCallEnum.idle);

  Future<List<PlacesModel>> getAllPlaces() async {
    return await placesRepositoryImpl.getAllPlaces();
  }
}
