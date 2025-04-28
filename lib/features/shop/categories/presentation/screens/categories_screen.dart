import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swd4_s1/core/layout/shop/controller/cubit.dart';
import 'package:swd4_s1/core/layout/shop/controller/state.dart';
import 'package:swd4_s1/core/shared/themes/controller/cubit.dart';
import 'package:swd4_s1/features/shop/home/data/model/categories_home_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildCategoriesLayout(
                context,
                cubit.categoriesHomeModel!.data.data[index]
              ),
          itemCount: cubit.categoriesHomeModel!.data.data.length,
        );
      },

    );
  }
}

Widget buildCategoriesLayout(context, CategoriesHomeDataDetailsModel model)=>Padding(
  padding: const EdgeInsets.all(10.0),
  child: Column(
    children: [
      Container(
        width: double.infinity,
        height: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color:
          ThemeModeCubit.get(context).isDark
              ? Colors.grey[300]
              : Colors.deepOrange,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                width: 150.0,
                height: 150.0,
                fit: BoxFit.cover,
                imageUrl:
                model.image,
                placeholder:
                    (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: Container(color: Colors.black),
                ),
                errorWidget:
                    (context, url, error) =>
                    Icon(Icons.error_outline, size: 100, color: Colors.grey[300]),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(model.name, style: Theme.of(context).textTheme.titleLarge,),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined,),
          ],
        ),
      ),
    ],
  ),
);
