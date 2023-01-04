import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:stoke_reviews_app/exports/exports.dart';

import 'package:stoke_reviews_app/features/search/application/search_places_service.dart';
import 'package:stoke_reviews_app/utils/api_call_enum.dart';

import '../../ranked_places/presentation/custom_widget/places_card.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var searchPlacesService =
        ref.watch(searchPlacesStateNotifierProvider.notifier);
    var searchPlacesServiceState = ref.watch(searchPlacesStateNotifierProvider);

    ref.listen<ApiCallEnum>(searchPlacesStateNotifierProvider,
        (previous, next) {
      if (next == ApiCallEnum.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(searchPlacesService.errorMessage),
          ),
        );
      }
    });

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          'Search Page',
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            CustomTextField(
              autoFocus: true,
              onChanged: (value) {
                searchPlacesService.searchPlaces(value);
              },
              hintText: 'Search for a place, restaurant, or hotel',
            ),
            const SizedBox(height: 10),
            searchPlacesServiceState == ApiCallEnum.loading
                ? CircularProgressIndicator()
                : SizedBox(),
            searchPlacesServiceState == ApiCallEnum.success
                ? Expanded(
                    child: ListView.builder(
                      itemCount: searchPlacesService.placesModelList.length,
                      itemBuilder: (context, index) {
                        return PlacesCard(
                          placesModel:
                              searchPlacesService.placesModelList[index],
                        );
                      },
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
