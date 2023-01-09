import 'package:dartz/dartz.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';
import 'package:stoke_reviews_app/features/review_and_comment/domain/rank_model.dart';
import 'package:stoke_reviews_app/features/review_and_comment/domain/review_model.dart';

abstract class ReviewRepository {
  Future<Either<String, bool>> postRating({required RankModel rankModel});

  Future<Either<String, bool>> postReview({required ReviewModel reviewModel});
  Future<Either<String, List<ReviewData>>> getReviewByPlaceId(
      {required String placeId});

  Future<List<ReviewData>> getAllReviews();
}
