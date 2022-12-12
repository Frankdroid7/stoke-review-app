import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/constants/api_constants.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';
import 'package:stoke_reviews_app/features/search/data/search_repository.dart';
import 'package:stoke_reviews_app/utils/app_custom_error.dart';

var searchPlacesRepoImpl =
    Provider<SearchRepositoryImpl>((ref) => SearchRepositoryImpl());

class SearchRepositoryImpl extends SearchRepository {
  var dio = Dio();

  @override
  Future<List<PlacesModel>> searchPlaces({required String name}) async {
    try {
      Response response = await dio
          .get(ApiConstants.getPlacesByName, queryParameters: {'name': name});

      debugPrint('SEARCH DATA -> ${response.data}');

      List responseList = response.data as List;
      return responseList.map((json) => PlacesModel.fromJson(json)).toList();
    } catch (e) {
      throw AppCustomError('Something went wrong, please try again.');
    }
  }
}
