import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BuildArticle extends StatelessWidget {
  final Map model;
  const BuildArticle({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CachedNetworkImage(
                  width: 150.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                  imageUrl: model['urlToImage'].toString(),
                  placeholder:
                      (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Container(color: Colors.black),
                  ),
                  errorWidget:
                      (context, url, error) =>
                      Icon(Icons.error_outline, size: 100, color: Colors.grey),
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: SizedBox(
                  height: 150.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model['title'].toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 10.0),
                      if(model['description'] != null)
                        Text(
                          model['description'].toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      Spacer(),
                      Text(
                        model['publishedAt'].toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
