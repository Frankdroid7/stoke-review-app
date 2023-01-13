import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/constants/api_constants.dart';
import 'package:stoke_reviews_app/features/review_and_comment/data/comment_repository.dart';
import 'package:stoke_reviews_app/utils/api_error.dart';
import 'package:stoke_reviews_app/utils/app_custom_error.dart';

import '../domain/comment_model.dart';

var commentRepoProvider = Provider<CommentRepoImpl>((ref) => CommentRepoImpl());

class CommentRepoImpl extends CommentRepository {
  Dio dio = Dio();

  @override
  Future<List<CommentModel>> getCommentByReviewId(int reviewID) async {
    try {
      print('TRYING TO GET COMMENT');
      Response response = await dio
          .get('${ApiConstants.getCommentsByReviewId}/?reviewId=$reviewID');

      print('new comments -> ${response.data}');
      List commentList = response.data;

      return commentList.map((e) => CommentModel.fromJson(e)).toList();
    } on DioError catch (e) {
      throw (apiError(e).errorMsg);
    }
  }

  @override
  Future<CommentModel> postComment(
      {required int userId, required CommentModel commentModel}) async {
    try {
      print(
          'POST COMMENT URL -> ${'${ApiConstants.postComment}?userId=$userId'}');
      Response response = await dio.post(ApiConstants.postComment,
          queryParameters: {'userId': userId}, data: commentModel.toJson());
      print('POST COMMENT DATA -> ${response.data}');
      return CommentModel.fromJson(response.data);
    } on DioError catch (e) {
      throw (apiError(e).errorMsg);
    }
  }
}
