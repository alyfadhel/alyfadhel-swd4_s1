import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swd4_s1/core/layout/shop/shop_layout.dart';
import 'package:swd4_s1/core/shared/const/constanse.dart';
import 'package:swd4_s1/core/shared/network/local/cache_helper.dart';
import 'package:swd4_s1/core/shared/widgets/my_button.dart';
import 'package:swd4_s1/core/shared/widgets/my_from_field.dart';
import 'package:swd4_s1/core/shared/widgets/my_txt_button.dart';
import 'package:swd4_s1/core/shared/widgets/toast_state.dart';
import 'package:swd4_s1/features/shop/users/login/presentation/controller/cubit.dart';
import 'package:swd4_s1/features/shop/users/login/presentation/controller/state.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              showToastState(
                msg: state.loginModel.message,
                state: ToastState.success,
              );
              CacheHelper.setData(
                  key: 'token',
                  value: state.loginModel.data!.token,
              ).then((value){
                    if(value){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ShopLayout()),
                      );
                    }
                    token = state.loginModel.data!.token;
              });
            } else {
              showToastState(
                msg: state.loginModel.message,
                state: ToastState.error,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: cubit.formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge!.copyWith(fontSize: 40.0),
                        ),
                        Text(
                          'Login to browse hot offers',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 40.0),
                        MyFromField(
                          controller: cubit.emailController,
                          type: TextInputType.emailAddress,
                          prefix: Icons.email_outlined,
                          text: 'email address',
                          radius: 10.0,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email must be not empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        MyFromField(
                          controller: cubit.passwordController,
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock_outline,
                          text: 'password',
                          radius: 10.0,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password must be not empty';
                            }
                            return null;
                          },
                          suffix: cubit.suffix,
                          isPassword: cubit.isPassword,
                          onSuffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                        ),
                        SizedBox(height: 40.0),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder:
                              (context) => MyButton(
                                onPressed: () {
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.getUser(
                                      email: cubit.emailController.text,
                                      password: cubit.passwordController.text,
                                    );
                                  }
                                },
                                text: 'login',
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                          fallback:
                              (context) =>
                                  Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account ?!',
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10.0),
                            MyTxtButton(
                              onPressed: () {},
                              text: 'Register',
                              isUpperCase: false,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: Colors.red, fontSize: 30.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
