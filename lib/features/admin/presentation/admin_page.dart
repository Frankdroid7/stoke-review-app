import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stoke_reviews_app/exports/exports.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';
import 'package:stoke_reviews_app/features/review_and_comment/application/comment_service.dart';
import 'package:stoke_reviews_app/features/review_and_comment/application/review_service.dart';
import 'package:stoke_reviews_app/features/review_and_comment/presentation/custom_widgets/review_list_tile.dart';

import '../../../utils/enums.dart';

class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> {
  @override
  void initState() {
    super.initState();
    getCheckBoxValueList();
  }

  bool dataLengthLoading = true;

  List<bool> checkBoxValueList = [];

  getCheckBoxValueList() async {
    dataLengthLoading = true;
    List<ReviewData> reviewDataLst = await ref
        .read(reviewServiceStateNotifierProvider.notifier)
        .getAllReviews();

    checkBoxValueList = List.generate(reviewDataLst.length, (index) => false);
    dataLengthLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          title: Text('Admin page'),
        ),
        child: dataLengthLoading
            ? const Center(child: CircularProgressIndicator())
            : ref.watch(getAllReviewsFuture).when(
                  data: (data) {
                    if (data.isEmpty) {
                      return const Text('No reviews at the moment');
                    }
                    return Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Reviews',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )),
                        Expanded(
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
                                      Checkbox(
                                          value: checkBoxValueList[index],
                                          onChanged: (value) {
                                            setState(() =>
                                                checkBoxValueList[index] =
                                                    value!);
                                          }),
                                    ],
                                  ),
                                ),
                              );
                            },
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
