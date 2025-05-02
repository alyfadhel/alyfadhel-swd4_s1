import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swd4_s1/core/layout/shop/controller/cubit.dart';
import 'package:swd4_s1/features/shop/home/data/model/home_model.dart';
import 'package:swd4_s1/features/shop/product_details/presentation/screens/product_details_screen.dart';

class BuildProductHome extends StatelessWidget {
  final ProductsModel model;

  const BuildProductHome({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailsScreen(id: model.id,)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CachedNetworkImage(
                      width: 150,
                      height: 150.0,
                      fit: BoxFit.fill,
                      imageUrl: model.image,
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
                  if (model.discount != 0)
                    Container(
                      decoration: BoxDecoration(color: Colors.red),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'DISCOUNT',
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  model.price.round().toString(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Colors.blue),
                ),
                SizedBox(width: 10.0),
                if (model.discount != 0)
                  Text(
                    model.oldPrice.round().toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                      decorationThickness: 1.5,
                    ),
                  ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    ShopCubit.get(context).getChangeFavorites(model.id);
                  },
                  icon: CircleAvatar(
                    radius: 14.0,
                    backgroundColor:
                        ShopCubit.get(context).favorites[model.id] == true
                            ? Colors.blue
                            : Colors.grey,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
