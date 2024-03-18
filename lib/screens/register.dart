import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lorby/components/my_button.dart';

import 'package:lorby/screens/verification.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? emailAddress;

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
  //using GlobalKey for validation
  final _formkey = GlobalKey<FormState>();

  var _enteredEmail = '';
  var _enteredUsername = '';
  var _enteredPassword = '';
  var _enteredConfirmPassword = '';
  var _isUploading = false;

  // final emailController = TextEditingController();
  // final usernameController = TextEditingController();
  // final passwordController = TextEditingController();
  // final passwordConfirmController = TextEditingController();
  bool _passwordVisible = false;

  void visSwitch() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void signUserUp() async {
    final isValid = _formkey.currentState!.validate();

    // if (!isValid ||
    //     _enteredEmail == '' ||
    //     _enteredUsername == '' ||
    //     _enteredPassword == '' ||
    //     _enteredConfirmPassword == '' ||
    //     _enteredPassword != _enteredConfirmPassword) {
    //   return;
    // }
    if (!isValid || _enteredPassword != _enteredConfirmPassword) {
      return;
    }

    _formkey.currentState!.save();

    try {
      setState(() {
        _isUploading = true;
      });
      if (_enteredPassword == _enteredConfirmPassword) {
        Dio dio = Dio();
        Response response = await dio.post(
          'https://wiut3.pythonanywhere.com/api/signup/',
          data: {
            'email': _enteredEmail,
            'username': _enteredUsername,
            'password': _enteredPassword,
          },
        );
        print(response.statusCode);
        if (response.statusCode == 201) {
          // Navigate to the home screen after successful login
          // String token = response.data['token'];
          // Store the token in shared preferences
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // await prefs.setString('token', token);

          String email = _enteredEmail;
          SharedPreferences prefsEmail = await SharedPreferences.getInstance();
          await prefsEmail.setString('email', email);
          setState(() {
            emailAddress = email;
          });

          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const VerificationScreen()));
        } else {
          // Handle login failure
          Navigator.maybePop(context);
          Fluttertoast.showToast(
            msg: 'Введи все поля верно!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          setState(() {
            _isUploading = false;
          });
        }
      }
    } catch (e) {
      print(e.toString());
      Navigator.maybePop(context);
      Fluttertoast.showToast(
        msg: 'Заполни все поля!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        _isUploading = false;
      });
    }

    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Center(
    //       child: CircularProgressIndicator(color: Colors.black),
    //     );
    //   },
    // );
  }

  // void showErrorMessage(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       duration: const Duration(seconds: 2),
  //       backgroundColor: Colors.redAccent,
  //       content: Text(message),
  //       action: SnackBarAction(
  //         label: '',
  //         onPressed: () {
  //           // Code to execute.
  //         },
  //       ),
  //     ),
  //   );
  // }

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
        centerTitle: true,
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
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 29, 65, 94)),
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Введи адрес почты',
                          hintStyle: const TextStyle(color: Colors.black45),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return 'Введи правильный адрес!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredEmail = value!;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 29, 65, 94)),
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Придумай логин',
                          hintStyle: const TextStyle(color: Colors.black45),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 8) {
                            return 'Введи правильный логин!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredUsername = value!;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 29, 65, 94)),
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Введи пароль',
                          hintStyle: const TextStyle(color: Colors.black45),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.black,
                            ),
                            onPressed: visSwitch,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 8 ||
                              value.trim().length > 15) {
                            return 'Введи правильный пароль!';
                          } else if (_enteredPassword !=
                              _enteredConfirmPassword) {
                            return 'Пароли должны совпадать c друг другом!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredPassword = value!;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 29, 65, 94)),
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Введи пароль',
                          hintStyle: const TextStyle(color: Colors.black45),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.black,
                            ),
                            onPressed: visSwitch,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 8 ||
                              value.trim().length > 15) {
                            return 'Введи правильный пароль!';
                          } else if (_enteredPassword !=
                              _enteredConfirmPassword) {
                            return 'Пароли должны совпадать c друг другом!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredConfirmPassword = value!;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    if (_isUploading) const CircularProgressIndicator(),
                    if (!_isUploading)
                      MyButton(
                        onTap: signUserUp,
                        buttonText: 'Далее',
                      ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),

              // MyTextField(
              //   controller: emailController,
              //   hintText: 'Введи адрес почты',
              //   obscureText: false,
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // MyTextField(
              //   controller: usernameController,
              //   hintText: 'Придумай логин',
              //   obscureText: false,
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // MyTextfieldPassword(
              //   controller: passwordController,
              //   passVisible: _passwordVisible,
              //   onTap: visSwitch,
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   padding: const EdgeInsets.only(left: 28),
              //   child: const Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text('* От 8 до 15 символов'),
              //       Text('* Строчные и прописные буквы'),
              //       Text('* Минимум 1 цифра'),
              //       Text('* Минимум 1 спецсимвол(!, ", #, \$...)'),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // MyTextfieldPassword(
              //   controller: passwordConfirmController,
              //   passVisible: _passwordVisible,
              //   onTap: visSwitch,
              // ),

              //button

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
