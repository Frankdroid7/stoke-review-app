import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/constants/app_constants.dart';

import '../../../../route/app_router.gr.dart';
import '../../application/places_service.dart';
import '../../domain/places_model.dart';

class PlacesCard extends ConsumerWidget {
  final PlacesModel placesModel;
  const PlacesCard({Key? key, required this.placesModel}) : super(key: key);

  final double imageHeight = 100;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        context.router.push(ReviewRoute(placesModel: placesModel));
      },
      child: SizedBox(
        height: 180,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  (placesModel.imageUrl == null ||
                          placesModel.imageUrl!.isEmpty)
                      ? stokeOnTrentPlaceHolderImage
                      : placesModel.imageUrl!,
                  height: imageHeight,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, _, __) {
                    return Image.network(
                      stokeOnTrentPlaceHolderImage,
                      height: imageHeight,
                      fit: BoxFit.fitWidth,
                    );
                  },
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          placesModel.placeName ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.rate_review_rounded,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              placesModel.reviewDtos
                                  .where((element) => element.status == true)
                                  .length
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              Icons.military_tech_outlined,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              placesModel.rank.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
