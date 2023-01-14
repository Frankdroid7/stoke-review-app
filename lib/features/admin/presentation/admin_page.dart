import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stoke_reviews_app/exports/exports.dart';
import 'package:stoke_reviews_app/features/admin/application/admin_service.dart';
import 'package:stoke_reviews_app/features/admin/domain/approve_review_model.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';
import 'package:stoke_reviews_app/features/review_and_comment/application/comment_service.dart';
import 'package:stoke_reviews_app/features/review_and_comment/application/review_service.dart';
import 'package:stoke_reviews_app/features/review_and_comment/presentation/custom_widgets/review_list_tile.dart';
import 'package:stoke_reviews_app/utils/utils.dart';

import '../../../utils/enums.dart';
import '../../review_and_comment/domain/review_model.dart';

class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> {
  @override
  Widget build(BuildContext context) {
    ApiCallEnum apiCallEnum = ref.watch(adminServiceProvider);
    AdminService adminService = ref.read(adminServiceProvider.notifier);

    ref.listen(adminServiceProvider, (previous, current) {
      if (current == ApiCallEnum.error) {
        showSnackbar(context: context, content: adminService.errorMessage);
      } else if (current == ApiCallEnum.success) {
        print('SUCCESS IS MINE');
        ref.invalidate(getAllReviewsFuture);
      }
    });

    return AppScaffold(
        appBar: AppBar(
          title: Text('Admin page'),
        ),
        child: ref.watch(getAllReviewsFuture).when(
              data: (data) {
                if (data.isEmpty) {
                  return const Text('No reviews at the moment');
                }
                return Column(
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Reviews',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () =>
                            ref.refresh(getAllReviewsFuture.future),
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            ReviewData reviewData = data[index];

                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(reviewData.reviewText),
                                    apiCallEnum == ApiCallEnum.loading
                                        ? const CircularProgressIndicator()
                                        : Checkbox(
                                            value: reviewData.status,
                                            onChanged: (value) {
                                              adminService.approveReview(
                                                  ApproveReview(
                                                      status: value!,
                                                      reviewId:
                                                          reviewData.reviewId));
                                            }),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (err, stack) {
                print('err: $err');
                return Text(err.toString() ?? 'Something went wrong.');
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }
}

List<ApprovedEnum> _approvedEnumList = [
  ApprovedEnum.approved,
  ApprovedEnum.disapproved,
];
