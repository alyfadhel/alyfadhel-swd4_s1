import 'package:flutter/material.dart';
import 'package:swd4_s1/features/counter/presentation/controller/cubit/cubit.dart';
import 'package:swd4_s1/features/messenger/presnetation/widgets/build_chat.dart';
import 'package:swd4_s1/features/messenger/presnetation/widgets/build_story.dart';
import 'package:swd4_s1/features/messenger/data/model/messenger_model.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                'https://img.freepik.com/free-photo/vertical-shot-leopard-its-habitat-safari-okavanga-delta-botswana_181624-56588.jpg?t=st=1741936058~exp=1741939658~hmac=9999bd8a3900de76d8ba1dd025e2ae3533416cbb458e53f750e59514c1a8d5dc&w=740',
              ),
            ),
            SizedBox(width: 20.0),
            Text(
              'Chat',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              radius: 16.0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 16.0,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              radius: 16.0,
              backgroundColor: Colors.blue,
              child: Icon(Icons.edit, color: Colors.white, size: 16.0),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 30.0),
                      SizedBox(width: 20.0),
                      Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              SizedBox(
                height: 105.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => BuildStory(model: messenger[index],),
                  separatorBuilder: (context, index) => SizedBox(width: 10.0),
                  itemCount: messenger.length,
                ),
              ),
              SizedBox(height: 40.0),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => BuildChat(model: messenger[index],),
                separatorBuilder: (context, index) => SizedBox(height: 20.0),
                itemCount: messenger.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


