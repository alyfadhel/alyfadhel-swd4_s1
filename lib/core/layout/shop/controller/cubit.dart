import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swd4_s1/core/layout/shop/controller/state.dart';
import 'package:swd4_s1/core/shared/const/constanse.dart';
import 'package:swd4_s1/core/shared/network/remote/shop_helper.dart';
import 'package:swd4_s1/features/home/presentation/screens/home_screen.dart';
import 'package:swd4_s1/features/shop/categories/presentation/screens/categories_screen.dart';
import 'package:swd4_s1/features/shop/favorites/data/favorites_model.dart';
import 'package:swd4_s1/features/shop/favorites/presentation/screens/favorites_screen.dart';
import 'package:swd4_s1/features/shop/home/data/model/categories_home_model.dart';
import 'package:swd4_s1/features/shop/home/data/model/change_favorites_model.dart';
import 'package:swd4_s1/features/shop/home/data/model/home_model.dart';
import 'package:swd4_s1/features/shop/product_details/data/model/product_details_model.dart';
import 'package:swd4_s1/features/shop/home/presentation/screens/shop_home_screen.dart';
import 'package:swd4_s1/features/shop/settings/data/model/profile_model.dart';
import 'package:swd4_s1/features/shop/settings/data/model/update_profile_model.dart';
import 'package:swd4_s1/features/shop/settings/presentation/screens/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialShopState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<String> titles = ['Home', 'Categories', 'Favorites', 'Settings'];
  List<Widget> screens = [
    ShopHomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  int currentIndex = 0;
  int current =0;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  void changeSmoothIndicator(index)
  {
    current = index;
    emit(ShopChangeSmoothIndicatorState());
  }

  void changeBottomNav(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  void changeLanguage() {
    if (language == 'ar') {
      language = 'en';
    } else {
      language = 'ar';
    }
    emit(ShopChangeLanguageState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopGetHomeDataLoadingState());

    ShopHelper.getData(
        url: homeEndPoint,
        token: token,
        lang: language,
    )
        .then((value) {
          homeModel = HomeModel.fromJson(value.data);
          debugPrint('The home is : ${value.data}');
          homeModel!.data!.products.forEach((element) {
            favorites.addAll({element.id: element.inFavorites});
          });
          debugPrint('The Home Favorites is $favorites');
          emit(ShopGetHomeDataSuccessState());
        })
        .catchError((error) {
          emit(ShopGetHomeDataErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void getChangeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesHomeLoadingState());

    ShopHelper.postData(
          url: changeFavoritesEndPoint,
          data: {'product_id': productId},
          token: token,
          lang: language,
        )
        .then((value) {
          changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
          if (!changeFavoritesModel!.status) {
            favorites[productId] = !favorites[productId]!;
          } else {
            getFavorites();
          }
          emit(ShopChangeFavoritesHomeSuccessState(changeFavoritesModel!));
        })
        .catchError((error) {
          emit(ShopChangeFavoritesHomeErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  FavoriteModel? favoriteModel;

  void getFavorites() {
    emit(ShopGetFavoritesHomeLoadingState());

    ShopHelper.getData(
        url: favoritesEndPoint,
        token: token,
        lang: language,
    )
        .then((value) {
          favoriteModel = FavoriteModel.fromJson(value.data);
          debugPrint('The Favorites Screen is: ${value.data}');
          emit(ShopGetFavoritesHomeSuccessState());
        })
        .catchError((error) {
          emit(ShopGetFavoritesHomeErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  CategoriesHomeModel? categoriesHomeModel;

  void getCategoriesHome() {
    emit(ShopGetCategoriesHomeLoadingState());

    ShopHelper.getData(
        url: categoriesEndPoint,
        lang: language,
    )
        .then((value) {
          categoriesHomeModel = CategoriesHomeModel.fromJson(value.data);
          debugPrint('The Home Categories is: ${value.data}');
          emit(ShopGetCategoriesHomeSuccessState());
        })
        .catchError((error) {
          emit(ShopGetCategoriesHomeErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  ProfileModel? profileModel;

  void getProfile() {
    emit(ShopGetProfileLoadingState());

    ShopHelper.getData(
        url: profileEndPoint,
        token: token,
        lang: language,
    )
        .then((value) {
          profileModel = ProfileModel.fromJson(value.data);
          debugPrint('The profile is: ${value.data}');
          emit(ShopGetProfileSuccessState());
        })
        .catchError((error) {
          emit(ShopGetProfileErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  UpdateProfileModel? updateProfileModel;

  void getUpdateProfile({
    required String name,
    required String email,
    required String phone,
  })
  {
    emit(ShopUpdateProfileLoadingState());

    ShopHelper.putData(
          url: updateProfileEndPoint,
          data: {'name': name, 'email': email, 'phone': phone},
          token: token,
          lang: language,
        )
        .then((value) {
          updateProfileModel = UpdateProfileModel.fromJSon(value.data);
          getProfile();
          emit(ShopUpdateProfileSuccessState(updateProfileModel!));
        })
        .catchError((error) {
          emit(ShopUpdateProfileErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  ProductDetailsModel? productDetailsModel;

  void getProductDetails(int id)
  {
    emit(ShopGetProductDetailsLoadingState());

    ShopHelper.getData(
        url: productEndPoint(id),
      token: token,
      lang: language,
    ).then((value){
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      debugPrint('The product details is : ${value.data}');
      emit(ShopGetProductDetailsSuccessState());
    }).catchError((error){
      emit(ShopGetProductDetailsErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }
}
