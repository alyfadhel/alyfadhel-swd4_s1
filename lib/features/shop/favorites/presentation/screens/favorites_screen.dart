import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swd4_s1/core/layout/shop/controller/cubit.dart';
import 'package:swd4_s1/core/layout/shop/controller/state.dart';
import 'package:swd4_s1/core/shared/widgets/toast_state.dart';
import 'package:swd4_s1/features/shop/favorites/data/favorites_model.dart';
import 'package:swd4_s1/features/shop/favorites/presentation/widgets%5D/build_favorites_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeFavoritesHomeSuccessState) {
          if (state.changeFavoritesModel.status) {
            showToastState(
              msg: state.changeFavoritesModel.message,
              state: ToastState.success,
            );
          } else {
            showToastState(
              msg: state.changeFavoritesModel.message,
              state: ToastState.error,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        if(cubit.favoriteModel!.data!.data.isNotEmpty){
          return ConditionalBuilder(
            condition: cubit.favoriteModel != null,
            builder:
                (context) => ListView.builder(
              itemBuilder:
                  (context, index) => BuildFavoritesItem(
                model: cubit.favoriteModel!.data!.data[index].product,
              ),
              itemCount: cubit.favoriteModel!.data!.data.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        }else{
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu,
                  color: Colors.grey[300],
                  size: 100.0,
                ),
                Text(
                  'No Favorites Yet...',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
