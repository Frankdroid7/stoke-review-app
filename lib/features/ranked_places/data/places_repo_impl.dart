import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/constants/api_constants.dart';
import 'package:stoke_reviews_app/features/ranked_places/data/places_repository.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';
import 'package:stoke_reviews_app/utils/app_custom_error.dart';

var placesRepoImpl = Provider((ref) => PlacesRepositoryImpl());

class PlacesRepositoryImpl extends PlacesRepository {
  @override
  Future<List<PlacesModel>> getAllPlaces() async {
    var dio = Dio();

    try {
      Response response = await dio.get(ApiConstants.getAllPlaces);

      List responseList = response.data;

      print(responseList);
      return responseList.map((json) => PlacesModel.fromJson(json)).toList();
    } on DioError catch (e) {
      throw (AppCustomError('An error, please pull down to refresh.'));
    }
  }
}
