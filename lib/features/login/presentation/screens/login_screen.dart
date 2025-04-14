import 'package:flutter/material.dart';
import 'package:swd4_s1/core/shared/widgets/my_button.dart';
import 'package:swd4_s1/core/shared/widgets/my_from_field.dart';
import 'package:swd4_s1/core/shared/widgets/my_txt_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

var emailController = TextEditingController();
var passwordController = TextEditingController();
var formKey = GlobalKey<FormState>();
bool isPassword = true;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        titleSpacing: 20.0,
        title: Text('Login Screen', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Login to browse hot offer',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                  SizedBox(height: 40.0),
                  MyFromField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    prefix: Icons.email_outlined,
                    text: 'Email Address',
                    isUppercase: false,
                    radius: 10.0,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must be not empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.0),
                  MyFromField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    prefix: Icons.lock_outline,
                    text: 'Password',
                    isUppercase: false,
                    radius: 10.0,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must be not empty';
                      }
                      return null;
                    },
                    suffix:
                        isPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                    isPassword: isPassword,
                    onSuffixPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  ),
                  SizedBox(height: 40.0),
                  MyButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
                    },
                    text: 'Login',
                    isUpperCase: false,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ?!',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(width: 10.0),
                      MyTxtButton(
                        onPressed: () {},
                        text: 'register',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
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
  }
}
