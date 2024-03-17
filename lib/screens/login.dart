import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lorby/components/my_button.dart';
import 'package:lorby/components/my_textfield.dart';
import 'package:lorby/components/my_textfield_password.dart';
import 'package:lorby/screens/home.dart';
import 'package:lorby/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? usernameAddress1;
String? tokenAddress1;

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    //required this.onTap,
  });

  //final Function()? onTap;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _passwordVisible = false;
  //final _isLoading = false;

  void visSwitch() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void loginUser() async {
    Dio dio = Dio();

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.black),
        );
      },
    );

    try {
      final data = {
        'username': usernameController.text,
        'password': passwordController.text,
      };
      Response response =
          await dio.post('https://wiut3.pythonanywhere.com/api/login/',
              options: Options(headers: {
                "Content-Type": "application/json",
              }),
              data: data);

      if (response.statusCode == 200) {
        print(response.data);
        //Navigate to the home screen after successful login
        String token = response.data['token'];
        String username = usernameController.text;
        // Store the token in shared preferences
        SharedPreferences prefsToken1 = await SharedPreferences.getInstance();
        SharedPreferences prefsUsername1 =
            await SharedPreferences.getInstance();
        await prefsToken1.setString('token', token);
        await prefsUsername1.setString('username', username);

        setState(() {
          usernameAddress1 = prefsUsername1.getString('username');
          tokenAddress1 = prefsToken1.getString('token');
        });

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const HomeScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Логин или пароль введен неверно!'),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            behavior: SnackBarBehavior.fixed,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } catch (e) {
      Navigator.maybePop(context);
      Fluttertoast.showToast(
        msg: 'Логин или пароль введен неверно!!!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        // leading: TextButton(
        //   style: const ButtonStyle(
        //     iconColor: MaterialStatePropertyAll(Colors.white),
        //     backgroundColor:
        //         MaterialStatePropertyAll(Color.fromARGB(255, 169, 152, 55)),
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   child: const SizedBox(
        //     width: 30,
        //     height: 10,
        //     child: Icon(Icons.arrow_back),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/sign_in/reg_icon.png',
                height: 240,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 30,
              ),
              Text('Велком бэк!',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                controller: usernameController,
                hintText: 'Введи логин',
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
                height: 25,
              ),
              MyButton(
                onTap: loginUser,
                buttonText: 'Войти',
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const RegisterScreen()));
                },
                child: const Text(
                  'У меня еще нет аккаунта',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
