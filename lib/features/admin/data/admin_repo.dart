import 'package:stoke_reviews_app/core/network_service.dart';
import 'package:stoke_reviews_app/features/admin/domain/approve_review_model.dart';

import '../../review_and_comment/domain/review_model.dart';

abstract class AdminRepo with NetworkService {
  Future<ReviewData> approveReview({required ApproveReview approveReview});
}
