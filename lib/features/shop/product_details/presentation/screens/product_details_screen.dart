import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swd4_s1/core/layout/shop/controller/cubit.dart';
import 'package:swd4_s1/core/layout/shop/controller/state.dart';
import 'package:swd4_s1/features/shop/product_details/data/model/product_details_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int id;

  const ProductDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getProductDetails(id),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.productDetailsModel != null,
              builder:
                  (context) => buildProductDetails(
                    context,
                    cubit.productDetailsModel!.data!,
                  ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}

Widget buildProductDetails(context, ProductDetailsDataModel model) => SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CarouselSlider(
              items:
                  model.images
                      .map(
                        (e) => ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: CachedNetworkImage(
                            width: double.infinity,
                            fit: BoxFit.fill,
                            imageUrl: e,
                            placeholder:
                                (context, url) => Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.white,
                                  child: Container(color: Colors.black),
                                ),
                            errorWidget:
                                (context, url, error) => Icon(
                                  Icons.error,
                                  size: 100.0,
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
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason){
                  ShopCubit.get(context).changeSmoothIndicator(index);
                }
              ),
            ),
            AnimatedSmoothIndicator(
              activeIndex: ShopCubit.get(context).current,
              count: ShopCubit.get(context).productDetailsModel!.data!.images.length,
              effect: const JumpingDotEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  jumpScale: .7,
                  verticalOffset: 20,
                  activeDotColor: Colors.indigo,
                  dotColor: Colors.grey,
              ),
            ),

          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              model.price.round().toString(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.blue,
              ),
            ),
            Text(
              model.oldPrice.round().toString(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.red,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.red,
                decorationThickness: 1.5,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
          ),
          child: Divider(
            height: 1.0,
            color: Colors.grey,
            thickness: 2,
          ),
        ),
        Text(
          model.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          model.description,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    ),
  ),
);
