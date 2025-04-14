import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swd4_s1/core/layout/shop/controller/state.dart';
import 'package:swd4_s1/features/home/presentation/screens/home_screen.dart';
import 'package:swd4_s1/features/shop/categories/presentation/screens/categories_screen.dart';
import 'package:swd4_s1/features/shop/favorites/presentation/screens/favorites_screen.dart';
import 'package:swd4_s1/features/shop/home/presentation/screens/shop_home_screen.dart';
import 'package:swd4_s1/features/shop/settings/presentation/screens/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit():super(InitialShopState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  List<BottomNavigationBarItem>items = [
    BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.category,),label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite,),label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings,),label: 'Settings'),
  ];
  List<String>titles = [
    'Home',
    'Categories',
    'Favorites',
    'Settings',
  ];
  List<Widget>screens = [
    ShopHomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  int currentIndex = 0;

  void changeBottomNav(index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
}