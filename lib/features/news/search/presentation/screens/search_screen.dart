import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swd4_s1/core/layout/news_app/controller/cubit.dart';
import 'package:swd4_s1/core/layout/news_app/controller/state.dart';
import 'package:swd4_s1/core/shared/widgets/my_from_field.dart';
import 'package:swd4_s1/core/shared/widgets/news_widgets/build_article_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var article = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                cubit.searchController.clear();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: 900.0,
                child: Column(
                  children: [
                    MyFromField(
                      controller: cubit.searchController,
                      type: TextInputType.text,
                      prefix: Icons.search,
                      text: 'search',
                      radius: 15.0,
                      onChanged: (value) {
                        cubit.getSearch(value);
                      },
                    ),
                    Expanded(
                      child: BuildArticleItem(
                          article: article,
                          isLoading: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
