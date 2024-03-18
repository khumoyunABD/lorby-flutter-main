import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lorby/screens/login.dart';
import 'package:lorby/screens/verification.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  //final SharedPreferences token1;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //logout function
  void logOut() async {
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
      // final token = {
      //   "Authorization": "Token $tokenAddress",
      // };
      Response response = await dio.post(
        'https://wiut3.pythonanywhere.com/api/logout/',
        options: Options(headers: {
          "Authorization": "Token ${tokenAddress2 ?? tokenAddress1}",
        }),
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const LoginScreen()));
      } else {
        Navigator.maybePop(context);
        Fluttertoast.showToast(
          msg: 'Не удалось выйти!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
          content: Text(e.toString()),
          action: SnackBarAction(
            label: '',
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Future<String> getUserToken() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   return prefs.getString('token') ??
    //       ''; // Return empty string if token not found
    // }

    // Future<String> fetchData() async {
    //   Dio dio = Dio();
    //   try {
    //     Response response = await dio.get(
    //       'https://wiut3.pythonanywhere.com/api/login/',
    //     );
    //     return response.data.toString();
    //   } catch (e) {
    //     print(e.toString());
    //     return 'Failed to fetch data';
    //   }
    // }

    // String data = 'Loading...';

    // @override
    // void initState() {
    //   super.initState();
    //   fetchData().then((value) {
    //     setState(() {
    //       data = value;
    //     });
    //   });
    // }

    // Future<String> getUsername(String token) async {
    //   String token = await getUserToken();
    //   String username = await getUsername(token);

    //   Dio dio = Dio();
    //   dio.options.headers['username'] = 'Bearer $token';

    //   try {
    //     Response response = await dio.get(
    //       'https://wiut3.pythonanywhere.com/api/login/',
    //     );

    //     return response.data['username'];
    //   } catch (e) {
    //     print(e.toString());
    //     return '';
    //   }
    // }

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Lorby'),
      //   centerTitle: true,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'С возвращением, ${usernameAddress2 ?? usernameAddress1}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Lorby - твой личный репетитор',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset('assets/sign_in/launch_image.png'),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.question,
                animType: AnimType.bottomSlide,
                title: 'Точно выйти?',
                //desc: 'Dialog description here.............',
                btnCancelOnPress: () {
                  Navigator.of(context).focusNode;
                },
                btnOkOnPress: logOut,
                btnOkText: 'Да',
                btnCancelText: 'Нет',
              ).show();
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return AlertDialog(
              //       content: const Text(
              //         "Точно выйти?",
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           color: Colors.black,
              //         ),
              //       ),
              //       actions: <Widget>[
              //         TextButton(
              //           onPressed: () {
              //             Navigator.of(context).pop();
              //           },
              //           child: const Text(
              //             "Нет, остаться",
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontWeight: FontWeight.normal,
              //             ),
              //           ),
              //         ),
              //         TextButton(
              //             style: TextButton.styleFrom(
              //               alignment: Alignment.center,
              //               backgroundColor: Colors.grey,
              //               //foregroundColor: Colors.green,
              //               //disabledBackgroundColor: Colors.black54,
              //               padding: const EdgeInsets.only(
              //                 right: 20,
              //                 left: 20,
              //                 // top: 20,
              //                 // bottom: 20,
              //               ),
              //               shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(10)),
              //             ),
              //             onPressed: logOut,
              //             child: const Text(
              //               "Да, точно",
              //               style: TextStyle(color: Colors.white),
              //             )),
              //       ],
              //     );
              //   },
              // );
            },
            child: const Text(
              'Выйти',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          //const Center(child: Text('Your token is ')),
          // Center(
          //   child: Text(
          //     tokenAddress2 ?? tokenAddress1!,
          //     style: const TextStyle(color: Colors.purpleAccent),
          //   ),
          // ),
        ],
      ),
    );
  }
}
