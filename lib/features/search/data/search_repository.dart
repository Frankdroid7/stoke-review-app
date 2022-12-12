import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';

abstract class SearchRepository {
  Future<List<PlacesModel>> searchPlaces({required String name});
}
