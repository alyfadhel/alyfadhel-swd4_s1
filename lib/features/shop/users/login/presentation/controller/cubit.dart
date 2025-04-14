import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swd4_s1/core/shared/const/constanse.dart';
import 'package:swd4_s1/core/shared/network/remote/shop_helper.dart';
import 'package:swd4_s1/features/shop/users/login/data/model/login_model.dart';
import 'package:swd4_s1/features/shop/users/login/presentation/controller/state.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit(): super(InitialShopState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  IconData suffix = Icons.visibility_off_outlined;



  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopChangeVisibilityLoginPassword());
  }

  LoginModel? loginModel;

  void getUser({
    required String email,
    required String password,
})
  {
    emit(ShopLoginLoadingState());

    ShopHelper.postData(
      url: loginEndPoint,
      data: {
        'email' : email,
        'password' : password,
      },
    ).then((value){
      loginModel = LoginModel.fromJson(value.data);
      debugPrint('The user is: ${value.data}');
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }
}