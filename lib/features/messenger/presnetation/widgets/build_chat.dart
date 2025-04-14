import 'package:flutter/material.dart';
import 'package:swd4_s1/features/messenger/data/model/messenger_model.dart';

class BuildChat extends StatelessWidget {
  final MessengerModel model;
  const BuildChat({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
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
        SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5.0),
              Text(
                model.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        CircleAvatar(radius: 5.0, backgroundColor: Colors.blue),
        SizedBox(width: 10.0),
        Text('02:00 pm', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
