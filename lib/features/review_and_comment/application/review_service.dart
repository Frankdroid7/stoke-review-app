import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';
import 'package:stoke_reviews_app/features/review_and_comment/domain/rank_model.dart';
import 'package:stoke_reviews_app/features/review_and_comment/domain/review_model.dart';
import 'package:stoke_reviews_app/utils/api_call_enum.dart';

import '../data/review_repository_impl.dart';

var reviewServiceStateNotifierProvider =
    StateNotifierProvider<ReviewService, ApiCallEnum>((ref) =>
        ReviewService(reviewRepoImpl: ref.read(reviewRepoImplProvider)));

class ReviewService extends StateNotifier<ApiCallEnum> {
  final ReviewRepoImpl reviewRepoImpl;
  ReviewService({required this.reviewRepoImpl}) : super(ApiCallEnum.error);

  List<ReviewData> reviewDataList = [];

  String errorMsg = '';
  Future postRating({required RankModel rankModel}) async {
    state = ApiCallEnum.loading;

    reviewRepoImpl.postRating(rankModel: rankModel).then((value) {
      value.fold((err) {
        errorMsg = err;
        state = ApiCallEnum.error;
      }, (r) {
        state = ApiCallEnum.success;
      });
    });
  }

  Future postReview({required ReviewModel reviewModel}) async {
    state = ApiCallEnum.loading;

    reviewRepoImpl.postReview(reviewModel: reviewModel).then((value) {
      value.fold((err) {
        errorMsg = err;
        state = ApiCallEnum.error;
      }, (r) {
        state = ApiCallEnum.success;
      });
    });
  }

  Future getReviewByPlaceId(String placeId) async {
    state = ApiCallEnum.loading;

    reviewRepoImpl.getReviewByPlaceId(placeId: placeId).then((value) {
      value.fold((err) {
        errorMsg = err;
        state = ApiCallEnum.loading;
      }, (data) {
        reviewDataList = data;
        state = ApiCallEnum.success;
      });
    });
  }
}
