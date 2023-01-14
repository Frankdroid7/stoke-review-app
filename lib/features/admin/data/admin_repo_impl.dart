import 'package:dio/dio.dart';
import 'package:stoke_reviews_app/features/admin/data/admin_repo.dart';
import 'package:stoke_reviews_app/features/admin/domain/approve_review_model.dart';
import 'package:stoke_reviews_app/features/review_and_comment/domain/review_model.dart';
import 'package:stoke_reviews_app/utils/api_error.dart';

import '../../../constants/api_constants.dart';
import '../../../exports/exports.dart';
import '../../authentication/domain/user_model.dart';

var adminRepoImplProvider = Provider((ref) => AdminRepoImpl(ref));

class AdminRepoImpl extends AdminRepo {
  Ref ref;
  AdminRepoImpl(this.ref);

  @override
  Future<ReviewData> approveReview(
      {required ApproveReview approveReview}) async {
    try {
      print(
          'payload ${approveReview.toJson()} AND ${ref.read(userStateProvider).userId}');
      Response response = await dio.put(ApiConstants.approveReview,
          options: Options(headers: {
            'Authorization': 'Bearer ${ref.read(userStateProvider).token}'
          }),
          queryParameters: {'userId': ref.read(userStateProvider).userId},
          data: approveReview.toJson());
      print('APPROVE REVIEW DATA -> ${response.data}');

      return ReviewData.fromJson(response.data);
    } on DioError catch (e) {
      print('APPROVE REVIEW ERROR -> ${e.toString()}');
      throw (apiError(e).errorMsg);
    }
  }
}
