import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/features/ranked_places/application/places_service.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';
import 'package:stoke_reviews_app/features/review_and_comment/domain/rank_model.dart';
import 'package:stoke_reviews_app/features/review_and_comment/domain/review_model.dart';

import '../../../utils/enums.dart';
import '../data/review_repository_impl.dart';

var reviewServiceStateNotifierProvider =
    StateNotifierProvider<ReviewService, ApiCallEnum>((ref) => ReviewService(
        reviewRepoImpl: ref.read(reviewRepoImplProvider), ref: ref));

class ReviewService extends StateNotifier<ApiCallEnum> {
  final Ref ref;
  final ReviewRepoImpl reviewRepoImpl;
  ReviewService({required this.reviewRepoImpl, required this.ref})
      : super(ApiCallEnum.error);

  List<ReviewData> reviewDataList = [];
  List<ReviewData> allReviewsDataList =
      []; //This will only be used in the admin page.

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
      }, (data) {
        state = ApiCallEnum.success;
      });
    });
  }

  Future getReviewByPlaceId(String placeId) async {
    state = ApiCallEnum.loading;

    reviewRepoImpl.getReviewByPlaceId(placeId: placeId).then((value) {
      value.fold((err) {
        errorMsg = err;
        state = ApiCallEnum.error;
      }, (data) {
        reviewDataList = data;
        state = ApiCallEnum.success;
      });
    });
  }

  Future<List<ReviewData>> getAllReviews() async {
    return reviewRepoImpl.getAllReviews();
  }

  Future<List<ReviewData>> getReviewsByPlaceId(int placeId) async {
    List<ReviewData> reviews =
        await reviewRepoImpl.getReviewsByPlaceId(placeId);

    return reviews.where((element) => element.status == true).toList();
  }
}

var getAllReviewsFuture = FutureProvider.autoDispose<List<ReviewData>>((ref) =>
    ref.read(reviewServiceStateNotifierProvider.notifier).getAllReviews());

var getReviewsByPlaceIdFuture = FutureProvider.autoDispose
    .family<List<ReviewData>, int>((ref, placeId) => ref
        .read(reviewServiceStateNotifierProvider.notifier)
        .getReviewsByPlaceId(placeId));
