import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swd4_s1/features/shop/home/data/model/categories_home_model.dart';

class BuildCategoriesHome extends StatelessWidget {
  final CategoriesHomeDataDetailsModel model;
  const BuildCategoriesHome({super.key, required this.model,});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: CachedNetworkImage(
            height: 150.0,
            width: 150.0,
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
                (context, url, error) => Icon(
              Icons.error_outline,
              size: 100,
              color: Colors.grey[300],
            ),
          ),
        ),
        Container(
          width: 150.0,
          decoration: BoxDecoration(
            color: Colors.black.withValues(
              alpha: .6,
            ),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(15.0,),
              bottomEnd: Radius.circular(15.0,),
            ),
          ),
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
