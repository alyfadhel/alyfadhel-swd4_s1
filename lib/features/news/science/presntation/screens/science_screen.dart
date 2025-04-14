import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swd4_s1/core/layout/news_app/controller/cubit.dart';
import 'package:swd4_s1/core/layout/news_app/controller/state.dart';
import 'package:swd4_s1/core/shared/widgets/news_widgets/build_article_item.dart';
import 'package:swd4_s1/features/news/business/presntation/screens/business_screen.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var article = NewsCubit.get(context).science;
        return BuildArticleItem(article: article);
      },
    );
  }
}
