import 'package:dartz/dartz.dart';
import 'package:stoke_reviews_app/features/review_and_comment/domain/comment_model.dart';

import '../../../utils/app_custom_error.dart';

abstract class CommentRepository {
  Future<List<CommentModel>> getCommentByReviewId(int reviewID);
  Future<CommentModel> postComment(
      {required int userId, required CommentModel commentModel});
}
