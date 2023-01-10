import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stoke_reviews_app/features/admin/presentation/admin_page.dart';
import 'package:stoke_reviews_app/features/authentication/domain/user_model.dart';

import 'package:stoke_reviews_app/features/ranked_places/application/places_service.dart';
import 'package:stoke_reviews_app/features/ranked_places/presentation/custom_widget/places_card.dart';
import 'package:stoke_reviews_app/utils/app_custom_error.dart';

import '../../../exports/exports.dart';
import '../../../route/app_router.gr.dart';

class HomePage extends HookConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  handleMenuClick(String str, BuildContext context) {
    if (str == 'Admin page') {
      context.router.push(const AdminRoute());
    } else if (str == 'Logout') {
      context.router.replaceAll([const RegistrationRoute()]);
    }
  }

  List<String> getMenuTitles = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      getMenuTitles =
          ref.read(userStateProvider.notifier).state.userRoleName == 'Admin'
              ? ['Admin page', 'Logout']
              : ['Logout'];
    });
    UserModel userModel = ref.read(userStateProvider);
    final getAllPlacesAsync = ref.watch(getAllPlacesFutureProvider);

    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hello, ${userModel.fullName}',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              PopupMenuButton(
                  onSelected: (str) => handleMenuClick(str, context),
                  itemBuilder: (context) {
                    return getMenuTitles
                        .map((e) => PopupMenuItem(value: e, child: Text(e)))
                        .toList();
                  }),
            ],
          ),
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
              return Column(
                children: [
                  Text(
                    err.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  ActionButton(
                      onPressed: () =>
                          ref.refresh(getAllPlacesFutureProvider.future),
                      title: 'Refresh')
                ],
              );
            },
            loading: () => Center(child: const CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}
