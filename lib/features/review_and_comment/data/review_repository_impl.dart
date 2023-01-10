import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/constants/api_constants.dart';
import 'package:stoke_reviews_app/features/authentication/domain/user_model.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';
import 'package:stoke_reviews_app/features/review_and_comment/data/review_repository.dart';
import 'package:stoke_reviews_app/features/review_and_comment/domain/rank_model.dart';
import 'package:stoke_reviews_app/features/review_and_comment/domain/review_model.dart';
import 'package:stoke_reviews_app/utils/api_error.dart';

var reviewRepoImplProvider = Provider((ref) => ReviewRepoImpl(ref));

class ReviewRepoImpl extends ReviewRepository {
  Ref ref;
  ReviewRepoImpl(this.ref);

  @override
  Future<Either<String, bool>> postRating(
      {required RankModel rankModel}) async {
    try {
      await dio.post(ApiConstants.postRating,
          queryParameters: {'userId': ref.read(userStateProvider).userId},
          data: rankModel.toJson());

      return right(true);
    } on DioError catch (e) {
      return left(apiError(e).errorMsg);
    }
  }

  @override
  Future<Either<String, ReviewData>> postReview(
      {required ReviewModel reviewModel}) async {
    try {
      Response response = await dio.post(ApiConstants.postReview,
          queryParameters: {'userId': ref.read(userStateProvider).userId},
          data: reviewModel.toJson());

      return right(ReviewData.fromJson(response.data));
    } on DioError catch (e) {
      return left(apiError(e).errorMsg);
    }
  }

  @override
  Future<Either<String, List<ReviewData>>> getReviewByPlaceId(
      {required String placeId}) async {
    try {
      Response response = await dio.get(ApiConstants.getCommentsByReviewId);

      List responseList = response.data;
      return right(responseList.map((e) => ReviewData.fromJson(e)).toList());
    } on DioError catch (e) {
      return left(apiError(e).errorMsg);
    }
  }

  @override
  Future<List<ReviewData>> getAllReviews() async {
    try {
      Response response = await dio.get(ApiConstants.getAllReviews);

      List responseList = response.data;
      return responseList.map((e) => ReviewData.fromJson(e)).toList();
    } on DioError catch (e) {
      return throw (apiError(e).errorMsg);
    }
  }

  @override
  Future<List<ReviewData>> getReviewsByPlaceId(int placeId) async {
    try {
      Response response = await dio
          .get('${ApiConstants.getReviewsByPlaceId}/?placeId=$placeId');

      List responseList = response.data;
      return responseList.map((e) => ReviewData.fromJson(e)).toList();
    } on DioError catch (e) {
      return throw (apiError(e).errorMsg);
    }
  }
}
