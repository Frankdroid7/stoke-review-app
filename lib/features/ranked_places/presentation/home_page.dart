import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:stoke_reviews_app/features/ranked_places/application/places_service.dart';
import 'package:stoke_reviews_app/features/ranked_places/presentation/custom_widget/places_card.dart';
import 'package:stoke_reviews_app/utils/app_custom_error.dart';

import '../../../exports/exports.dart';
import '../../../route/app_router.gr.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getAllPlacesAsync = ref.watch(getAllPlacesFutureProvider);

    return AppScaffold(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              context.router.push(const SearchRoute());
            },
            child: CustomTextField(
              enabled: false,
              hintText: 'Search for place, restaurant, hotel, etc',
            ),
          ),
          SizedBox(height: 10),
          getAllPlacesAsync.when(
            data: (placesModelList) {
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    return ref.refresh(getAllPlacesFutureProvider.future);
                  },
                  child: ListView.builder(
                    itemCount: placesModelList.length,
                    itemBuilder: (context, index) {
                      return PlacesCard(
                        placesModel: placesModelList[index],
                      );
                    },
                  ),
                ),
              );
            },
            error: (err, stack) {
              err as AppCustomError;
              return Text(
                err.errorMsg,
                style: const TextStyle(
                  fontSize: 18,
                ),
              );
            },
            loading: () => const CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
