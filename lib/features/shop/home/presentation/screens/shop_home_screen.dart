import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swd4_s1/core/layout/shop/controller/cubit.dart';
import 'package:swd4_s1/core/layout/shop/controller/state.dart';
import 'package:swd4_s1/core/shared/widgets/toast_state.dart';
import 'package:swd4_s1/features/shop/home/presentation/widgets/build_item.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({super.key});

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
        return ConditionalBuilder(
          condition:
              cubit.homeModel != null && cubit.categoriesHomeModel != null,
          builder: (context) => BuildItem(model: cubit.homeModel!),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
