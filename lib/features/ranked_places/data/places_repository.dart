import 'package:dartz/dartz.dart';

import '../../../utils/app_custom_error.dart';
import '../../ranked_places/domain/places_model.dart';

abstract class PlacesRepository {
  Future<List<PlacesModel>> getAllPlaces();
}
