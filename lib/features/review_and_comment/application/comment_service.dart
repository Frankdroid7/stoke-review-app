import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';
import 'package:stoke_reviews_app/utils/app_custom_error.dart';

import '../../../utils/enums.dart';
import '../data/comment_repository_impl.dart';
import '../domain/comment_model.dart';

var reviewDataStateProvider =
    StateProvider<ReviewData>((ref) => ReviewData.emptyData());

var placesModelStateProvider =
    StateProvider<PlacesModel>((ref) => PlacesModel.emptyData());

var commentServiceStateProvider =
    StateNotifierProvider<CommentService, ApiCallEnum>(
        (ref) => CommentService(ref.read(commentRepoProvider), ref));

class CommentService extends StateNotifier<ApiCallEnum> {
  Ref ref;
  CommentRepoImpl commentRepoImpl;
  CommentService(this.commentRepoImpl, this.ref) : super(ApiCallEnum.idle);

  String errorMessage = '';

  Future<List<CommentModel>> getCommentsByReviewId(int reviewId) async {
    try {
      List<CommentModel> comment =
          await commentRepoImpl.getCommentByReviewId(reviewId);
      return comment;
    } catch (e) {
      throw (e.toString());
    }
  }

  Future postComment(
      {required int userId, required CommentModel commentModel}) async {
    state = ApiCallEnum.loading;

    try {
      await commentRepoImpl.postComment(
          userId: userId, commentModel: commentModel);

      state = ApiCallEnum.success;
    } catch (e) {
      errorMessage = e.toString();
      state = ApiCallEnum.error;
    }
  }
}

var getCommentsByReviewIdFutureProvider =
    FutureProvider.autoDispose.family<List<CommentModel>, int>((ref, reviewId) {
  print('GET COMMENTS BY REVIEW ID');
  return ref
      .read(commentServiceStateProvider.notifier)
      .getCommentsByReviewId(reviewId);
});
