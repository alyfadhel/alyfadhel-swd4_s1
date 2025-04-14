import 'package:flutter/material.dart';
import 'package:swd4_s1/features/messenger/data/model/messenger_model.dart';

class BuildStory extends StatelessWidget {
  final MessengerModel model;
  const BuildStory({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.0,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                  model.image,
                ),
              ),
              CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.white,
                child: CircleAvatar(radius: 8.0, backgroundColor: Colors.green),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
