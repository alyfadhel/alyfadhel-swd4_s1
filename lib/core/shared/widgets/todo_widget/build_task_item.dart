import 'package:flutter/material.dart';
import 'package:swd4_s1/core/layout/todo/controller/cubit/cubit.dart';

class BuildTaskItem extends StatelessWidget {
  final Map model;
  const BuildTaskItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction){
        AppCubit.get(context).deleteDataFromDatabase(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.blue,
              child: Text(
                model['time'],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model['title'],
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    model['date'],
                    style: TextStyle(color: Colors.grey, fontSize: 15.0),
                  ),
                ],
              ),
            ),
            IconButton(onPressed: (){
              AppCubit.get(context).updateDateFromDatabase(status: 'done', id: model['id']);
            }, icon: Icon(Icons.check_box_outlined,color: Colors.green,)),
            IconButton(onPressed: (){
              AppCubit.get(context).updateDateFromDatabase(status: 'archive', id: model['id']);
            }, icon: Icon(Icons.archive_outlined,color: Colors.black45,)),
          ],
        ),
      ),
    );
  }
}
