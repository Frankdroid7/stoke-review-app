import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/appwide_custom_widgets/custom_textfield.dart';
import 'package:stoke_reviews_app/features/authentication/domain/user_model.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';
import 'package:stoke_reviews_app/features/review_and_comment/application/comment_service.dart';
import 'package:stoke_reviews_app/utils/api_call_enum.dart';

import '../../domain/comment_model.dart';
import 'comment_tile.dart';

class ReviewListTile extends HookConsumerWidget {
  final ReviewData reviewData;
  final PlacesModel placesModel;
  const ReviewListTile(
      {Key? key, required this.placesModel, required this.reviewData})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
          onTap: () {
            ref.read(reviewDataStateProvider.notifier).state = reviewData;
            ref.read(placesModelStateProvider.notifier).state = placesModel;

            displayModalBottomSheet(context, ref);
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: const Icon(Icons.person),
          title: Text(
            reviewData.reviewText,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text('Alon James'),
          trailing: getListTileTrailingWidget(ref, reviewData.reviewId)),
    );
  }

  getListTileTrailingWidget(WidgetRef ref, int reviewId) {
    return ref.watch(getCommentsByReviewIdFutureProvider(reviewId)).when(
      data: (data) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.edit),
            const SizedBox(width: 3),
            Text(data.length.toString()),
          ],
        );
      },
      error: (error, stack) {
        return const Text('Something went wrong');
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }

  displayModalBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const OutlineInputBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            borderSide: BorderSide.none),
        builder: (context) => const BottomSheetWidget());
  }
}

class BottomSheetWidget extends HookConsumerWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var commentCtrl = useTextEditingController();
    CommentService commentService =
        ref.watch(commentServiceStateProvider.notifier);
    ApiCallEnum commentServiceState = ref.watch(commentServiceStateProvider);
    ReviewData reviewData = ref.read(reviewDataStateProvider.notifier).state;
    PlacesModel placesModel = ref.read(placesModelStateProvider.notifier).state;

    ref.listen(commentServiceStateProvider, (previous, current) {
      if (current == ApiCallEnum.success) {
        commentCtrl.clear();
        ref.refresh(
            getCommentsByReviewIdFutureProvider(reviewData.reviewId).future);
      }
    });
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomSheet: SizedBox(
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CustomTextField(
                      controller: commentCtrl,
                      hintText: 'Type in your comments...'),
                ),
              ),
              commentServiceState == ApiCallEnum.loading
                  ? const CircularProgressIndicator()
                  : InkWell(
                      onTap: () {
                        CommentModel commentModel = CommentModel(
                          commentId: 0,
                          reviewId: reviewData.reviewId,
                          commentText: commentCtrl.text,
                        );

                        ref
                            .read(commentServiceStateProvider.notifier)
                            .postComment(
                              userId: ref
                                  .read(userStateProvider.notifier)
                                  .state
                                  .userId,
                              commentModel: commentModel,
                            );
                      },
                      child: const Icon(
                        Icons.send,
                        size: 28,
                      ),
                    ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                ' · ${placesModel.placeName} ·' ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                child: Text(
                  reviewData.reviewText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: commentService.commentModelList.length,
                  itemBuilder: (context, index) {
                    // return Text(
                    //     commentService.commentModelList[index].commentText!);
                    return CommentTile(
                        commentModel: commentService.commentModelList[index]);
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
