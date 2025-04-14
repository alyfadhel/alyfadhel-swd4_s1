import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swd4_s1/core/layout/news_app/controller/state.dart';
import 'package:swd4_s1/core/shared/network/remote/dio_helper.dart';
import 'package:swd4_s1/features/news/business/presntation/screens/business_screen.dart';
import 'package:swd4_s1/features/news/science/presntation/screens/science_screen.dart';
import 'package:swd4_s1/features/news/sports/presntation/screens/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit():super(InitialNewsState());
  
  static NewsCubit get(context)=>BlocProvider.of(context);
  
  int currentIndex = 0;
  List<BottomNavigationBarItem>items = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports_baseball), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];
  List<String>titles = [
    'Business',
    'Sports',
    'Science',
  ];
  List<Widget>screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNav(index)
  {
    currentIndex = index;
    emit(NewsChangeBottomNav());
  }

  List<dynamic>business = [];
  List<dynamic>sports = [];
  List<dynamic>science = [];
  List<dynamic>search = [];

  var searchController = TextEditingController();

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    NewsHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'apiKey' : 'c799708afa624ae3b9742682fb271251',
          'country' : 'us',
          'category' : 'business',
        },
    )
        .then((value){
          business = value.data['articles'];
          debugPrint('The business is: ${value.data['articles']}');
          emit(NewsGetBusinessSuccessState());
    },
    ).catchError((error){
      emit(NewsGetBusinessErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }

  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    NewsHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'apiKey' : 'c799708afa624ae3b9742682fb271251',
        'country' : 'us',
        'category' : 'sports',
      },
    )
        .then((value){
      sports = value.data['articles'];
      debugPrint('The Sports is: ${value.data['articles']}');
      emit(NewsGetSportsSuccessState());
    },
    ).catchError((error){
      emit(NewsGetSportsErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }

  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    NewsHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'apiKey' : 'c799708afa624ae3b9742682fb271251',
        'country' : 'us',
        'category' : 'science',
      },
    )
        .then((value){
      science = value.data['articles'];
      debugPrint('The Science is: ${value.data['articles']}');
      emit(NewsGetScienceSuccessState());
    },
    ).catchError((error){
      emit(NewsGetScienceErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());
    NewsHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'apiKey' : 'c799708afa624ae3b9742682fb271251',
        'q' : value,
      },
    )
        .then((value){
      search = value.data['articles'];
      debugPrint('The Search is: ${value.data['articles']}');
      emit(NewsGetSearchSuccessState());
    },
    ).catchError((error){
      emit(NewsGetSearchErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }
  
}