import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';
import 'package:stoke_reviews_app/utils/api_call_enum.dart';
import 'package:stoke_reviews_app/utils/app_custom_error.dart';

import '../data/comment_repository_impl.dart';
import '../domain/comment_model.dart';

var reviewDataStateProvider =
    StateProvider<ReviewData>((ref) => ReviewData.emptyData());

var placesModelStateProvider =
    StateProvider<PlacesModel>((ref) => PlacesModel.emptyData());

var commentServiceStateProvider =
    StateNotifierProvider<CommentService, ApiCallEnum>(
        (ref) => CommentService(ref.read(commentRepoProvider)));

class CommentService extends StateNotifier<ApiCallEnum> {
  CommentRepoImpl commentRepoImpl;
  CommentService(this.commentRepoImpl) : super(ApiCallEnum.idle);

  String errorMessage = '';
  List<CommentModel> commentModelList = [];

  Future<List<CommentModel>> getCommentsByReviewId(int reviewId) async {
    List<CommentModel> comment =
        await commentRepoImpl.getCommentByReviewId(reviewId);
    commentModelList = comment;
    return comment;
  }

  Future postComment(
      {required int userId, required CommentModel commentModel}) async {
    state = ApiCallEnum.loading;

    try {
      CommentModel _commentModel = await commentRepoImpl.postComment(
          userId: userId, commentModel: commentModel);

      commentModelList.add(_commentModel);

      state = ApiCallEnum.success;
    } catch (e) {
      errorMessage = e.toString();
      state = ApiCallEnum.error;
    }
  }
}

var getCommentsByReviewIdFutureProvider =
    FutureProvider.autoDispose.family<List<CommentModel>, int>((ref, reviewId) {
  return ref
      .read(commentServiceStateProvider.notifier)
      .getCommentsByReviewId(reviewId);
});
