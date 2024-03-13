import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lorby/components/my_button.dart';
import 'package:lorby/components/my_textfield.dart';
import 'package:lorby/components/my_textfield_password.dart';
import 'package:lorby/screens/home.dart';
import 'package:lorby/screens/verification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
    //required this.onTap,
  });

  //final Function()? onTap;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool _passwordVisible = false;

  void visSwitch() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void signUserUp() async {
    Dio dio = Dio();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const VerificationScreen()));
    try {
      if (passwordConfirmController == passwordConfirmController) {}
      Response response = await dio.post(
        'https://wiut3.pythonanywhere.com/api/signup/',
        data: {
          'email': emailController.text,
          'username': usernameController.text,
          'password': passwordController.text,
        },
      );
      if (response.statusCode == 201) {
        // Navigate to the home screen after successful login
        String token = response.data['token'];
        // Store the token in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const VerificationScreen()));
      } else {
        // Handle login failure
        const AlertDialog(
          title: Text('Login Failed'),
        );
      }
    } catch (e) {
      AlertDialog(
        title: Text(e.toString()),
      );
    }
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.redAccent,
        content: Text(message),
        action: SnackBarAction(
          label: '',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Регистрация',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                'Создать аккаунт',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Lorby',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(
                height: 50,
              ),
              // Text(
              //   'Let\'s create a new account!',
              //   style: TextStyle(
              //     color: Theme.of(context).colorScheme.onTertiary,
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),

              MyTextField(
                controller: emailController,
                hintText: 'Введи адрес почты',
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: usernameController,
                hintText: 'Придумай логин',
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextfieldPassword(
                controller: passwordController,
                passVisible: _passwordVisible,
                onTap: visSwitch,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 28),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('* От 8 до 15 символов'),
                    Text('* Строчные и прописные буквы'),
                    Text('* Минимум 1 цифра'),
                    Text('* Минимум 1 спецсимвол(!, ", #, \$...)'),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextfieldPassword(
                controller: passwordConfirmController,
                passVisible: _passwordVisible,
                onTap: visSwitch,
              ),
              const SizedBox(
                height: 25,
              ),
              MyButton(
                onTap: signUserUp,
                buttonText: 'Далее',
              ),
              const SizedBox(
                height: 50,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(25),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Divider(
              //           thickness: 1,
              //           color: Colors.red.shade300,
              //         ),
              //       ),
              //       const Padding(
              //         padding: EdgeInsets.symmetric(
              //           horizontal: 10,
              //         ),
              //         child: Text(
              //           'Or continue with...',
              //           style: TextStyle(fontSize: 16, color: Colors.black54),
              //         ),
              //       ),
              //       Expanded(
              //         child: Divider(
              //           thickness: 1,
              //           color: Colors.red.shade300,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SquareTile(
              //       onTap: () => AuthService().signInWithGoogle(),
              //       imagePath: 'assets/sign_in/google.png',
              //     ),
              //     const SizedBox(
              //       width: 40,
              //     ),
              //     SquareTile(
              //       onTap: () {},
              //       imagePath: 'assets/sign_in/apple.png',
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text('Already registered?'),
              //     const SizedBox(
              //       width: 5,
              //     ),
              //     Center(
              //       child: GestureDetector(
              //         onTap: widget.onTap,
              //         child: const Text(
              //           'Login now',
              //           style: TextStyle(
              //             color: Colors.blue,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 50,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
