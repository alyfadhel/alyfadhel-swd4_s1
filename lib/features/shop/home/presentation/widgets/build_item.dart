import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swd4_s1/core/layout/shop/controller/cubit.dart';
import 'package:swd4_s1/features/shop/home/data/model/home_model.dart';
import 'package:swd4_s1/features/shop/home/presentation/widgets/build_categories_home.dart';
import 'package:swd4_s1/features/shop/home/presentation/widgets/build_product_home.dart';



class BuildItem extends StatelessWidget {
  final HomeModel model;

  const BuildItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items:
                model.data!.banners
                    .map(
                      (e) => ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: CachedNetworkImage(
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: e.image,
                          placeholder:
                              (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: Container(color: Colors.black),
                              ),
                          errorWidget:
                              (context, url, error) => Icon(
                                Icons.error_outline,
                                size: 100,
                                color: Colors.grey[300],
                              ),
                        ),
                      ),
                    )
                    .toList(),
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  height: 150.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder:
                        (context, index) => BuildCategoriesHome(
                          model:
                              ShopCubit.get(
                                context,
                              ).categoriesHomeModel!.data.data[index],
                        ),
                    separatorBuilder: (context, index) => SizedBox(width: 20.0),
                    itemCount:
                        ShopCubit.get(
                          context,
                        ).categoriesHomeModel!.data.data.length,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'New Products',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
          SizedBox(height: 30.0),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1 / 1.5,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(
              ShopCubit.get(context).homeModel!.data!.products.length,
              (index) => BuildProductHome(
                model:
                ShopCubit.get(context).homeModel!.data!.products[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


