import 'package:stoke_reviews_app/exports/exports.dart';
import 'package:stoke_reviews_app/features/admin/domain/approve_review_model.dart';
import 'package:stoke_reviews_app/utils/enums.dart';

import '../data/admin_repo_impl.dart';

var adminServiceProvider = StateNotifierProvider<AdminService, ApiCallEnum>(
    (ref) => AdminService(ref.read(adminRepoImplProvider)));

class AdminService extends StateNotifier<ApiCallEnum> {
  AdminRepoImpl adminRepoImpl;
  AdminService(this.adminRepoImpl) : super(ApiCallEnum.idle);

  String errorMessage = '';

  approveReview(ApproveReview approveReview) {
    print('STATUS: -> ${approveReview.status}');
    state = ApiCallEnum.loading;

    try {
      adminRepoImpl.approveReview(approveReview: approveReview);
      state = ApiCallEnum.success;
    } catch (e) {
      state = ApiCallEnum.error;
      errorMessage = e.toString();
    }
  }
}
