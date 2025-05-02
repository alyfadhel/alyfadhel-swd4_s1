import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swd4_s1/core/layout/shop/controller/cubit.dart';
import 'package:swd4_s1/core/layout/shop/controller/state.dart';
import 'package:swd4_s1/core/shared/network/local/cache_helper.dart';
import 'package:swd4_s1/core/shared/themes/controller/cubit.dart';
import 'package:swd4_s1/core/shared/widgets/my_button.dart';
import 'package:swd4_s1/core/shared/widgets/my_from_field.dart';
import 'package:swd4_s1/features/shop/settings/data/model/profile_model.dart';
import 'package:swd4_s1/features/shop/users/login/presentation/screens/shop_login_screen.dart';

class BuildProfile extends StatelessWidget {
  final ProfileDataModel model;

  const BuildProfile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        cubit.nameController.text = model.name;
        cubit.emailController.text = model.email;
        cubit.phoneController.text = model.phone;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if(state is ShopUpdateProfileSuccessState)
                  LinearProgressIndicator(),
                if(state is ShopUpdateProfileSuccessState)
                  SizedBox(
                    height: 30.0,
                  ),
                SizedBox(
                  height: 250,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Container(
                          width: double.infinity,
                          height: 200.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'https://student.valuxapps.com/storage/uploads/users/t0DBmCJzRs_1745829178.jpeg',
                              ),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 65.0,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            'https://student.valuxapps.com/storage/uploads/users/t0DBmCJzRs_1745829178.jpeg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.0),
                MyFromField(
                  controller: cubit.nameController,
                  type: TextInputType.text,
                  prefix: Icons.person,
                  text: 'name',
                  radius: 10.0,
                ),
                SizedBox(height: 20.0),
                MyFromField(
                  controller: cubit.emailController,
                  type: TextInputType.emailAddress,
                  prefix: Icons.email_outlined,
                  text: 'email address',
                  radius: 10.0,
                ),
                SizedBox(height: 20.0),
                MyFromField(
                  controller: cubit.phoneController,
                  type: TextInputType.phone,
                  prefix: Icons.phone_android,
                  text: 'phone',
                  radius: 10.0,
                ),
                SizedBox(height: 20.0),
                MyButton(
                  onPressed: () {
                    CacheHelper.removeData(key: 'token').then((value) {
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopLoginScreen(),
                          ),
                        );
                      }
                    });
                  },
                  text: 'LogOut',
                  background:
                      ThemeModeCubit.get(context).isDark
                          ? Colors.blue
                          : Colors.deepOrange,
                  isUpperCase: false,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Colors.white),
                ),
                SizedBox(height: 20.0),
                MyButton(
                  onPressed: () {
                    cubit.getUpdateProfile(
                      name: cubit.nameController.text,
                      email: cubit.emailController.text,
                      phone: cubit.phoneController.text,
                    );
                  },
                  text: 'Update',
                  background:
                      ThemeModeCubit.get(context).isDark
                          ? Colors.blue
                          : Colors.deepOrange,
                  isUpperCase: false,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
