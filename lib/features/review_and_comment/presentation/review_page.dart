import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';
import 'package:stoke_reviews_app/features/review_and_comment/application/review_service.dart';
import 'package:stoke_reviews_app/features/review_and_comment/data/review_repository_impl.dart';
import 'package:stoke_reviews_app/features/review_and_comment/domain/rank_model.dart';
import 'package:stoke_reviews_app/features/review_and_comment/domain/review_model.dart';
import 'package:stoke_reviews_app/shared_widgets/app_scaffold.dart';
import 'package:stoke_reviews_app/shared_widgets/custom_textfield.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/app_constants.dart';
import '../../../exports/exports.dart';
import '../../../shared_widgets/action_button.dart';
import '../../../utils/enums.dart';
import 'custom_widgets/review_list_tile.dart';

class ReviewPage extends HookConsumerWidget {
  final PlacesModel placesModel;

  double reviewRating = 0.0;

  ReviewPage({Key? key, required this.placesModel}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var reviewTextEditingCtrl = useTextEditingController();
    ValueNotifier<bool> showPostReviewWidget = useState(false);
    ApiCallEnum reviewServiceState =
        ref.read(reviewServiceStateNotifierProvider);
    ReviewService reviewService =
        ref.read(reviewServiceStateNotifierProvider.notifier);

    ref.listen<ApiCallEnum>(reviewServiceStateNotifierProvider,
        (previous, current) {
      if (current == ApiCallEnum.success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          'Review Posted',
          style: TextStyle(color: Colors.blue),
        )));
        reviewTextEditingCtrl.clear();
        showPostReviewWidget.value = false;
        ref.invalidate(getReviewsByPlaceIdFuture(placesModel.placeId));
      } else if (current == ApiCallEnum.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            reviewService.errorMsg,
            style: const TextStyle(
              color: Colors.red,
            ),
          )),
        );
      }
    });

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Review page'),
      ),
      child: RefreshIndicator(
        onRefresh: () => Future(() =>
            ref.invalidate(getReviewsByPlaceIdFuture(placesModel.placeId))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                (placesModel.imageUrl == null || placesModel.imageUrl!.isEmpty)
                    ? stokeOnTrentPlaceHolderImage
                    : placesModel.imageUrl!,
                height: 140,
                fit: BoxFit.fitWidth,
                errorBuilder: (context, _, __) {
                  return Image.network(
                    stokeOnTrentPlaceHolderImage,
                    height: 140,
                    fit: BoxFit.fitWidth,
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(
                placesModel.placeName,
                style: const TextStyle(fontSize: 22),
              ),
              placesModel.description.isEmpty
                  ? const SizedBox.shrink()
                  : Text(
                      placesModel.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
              placesModel.description.isEmpty
                  ? const SizedBox.shrink()
                  : const SizedBox(height: 10),
              const Divider(thickness: 2),
              InkWell(
                onTap: () {
                  showPostReviewWidget.value = !showPostReviewWidget.value;
                },
                child: const Text(
                  'Post a review',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
              Visibility(
                visible: showPostReviewWidget.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RatingBar.builder(
                      minRating: 1,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        reviewRating = rating;
                      },
                    ),
                    CustomTextField(
                      maxLines: 4,
                      controller: reviewTextEditingCtrl,
                      labelText: '\nWrite your review...',
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    reviewServiceState == ApiCallEnum.loading
                        ? const CircularProgressIndicator()
                        : ActionButton(
                            onPressed: () {
                              if (reviewRating > 0.0) {
                                RankModel rankModel = RankModel(
                                  placeId: placesModel.placeId,
                                  placeName: placesModel.placeName,
                                  ranking: reviewRating.toInt(),
                                );
                                reviewService.postRating(rankModel: rankModel);
                              }
                              if (reviewTextEditingCtrl.text.isNotEmpty) {
                                ReviewModel reviewModel = ReviewModel(
                                    placeName: placesModel.placeName,
                                    placeId: placesModel.placeId,
                                    reviewText: reviewTextEditingCtrl.text);
                                reviewService.postReview(
                                    reviewModel: reviewModel);
                              }
                            },
                            title: 'Post Review',
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Reviews',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8),
              ref.watch(getReviewsByPlaceIdFuture(placesModel.placeId)).when(
                  data: (data) {
                if (data.isEmpty) {
                  return const Center(
                    child: Text(
                      'No reviews\nPost a review',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ReviewListTile(
                            placesModel: placesModel,
                            reviewData: data[index],
                          );
                        }),
                  );
                }
              }, error: (error, stack) {
                return Text(error.toString());
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
