import 'package:flutter/material.dart';
import 'package:lorby/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.token1,
  });

  final SharedPreferences token1;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          const Text(
            'С возвращением, 3w_team',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset('assets/sign_in/launch_image.png'),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: const Text(
                        "Точно выйти?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                            style: TextButton.styleFrom(
                              alignment: Alignment.center,
                              backgroundColor: Colors.grey,
                              //foregroundColor: Colors.green,
                              //disabledBackgroundColor: Colors.black54,
                              padding: const EdgeInsets.only(
                                right: 20,
                                left: 20,
                                // top: 20,
                                // bottom: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const LoginScreen()));
                            },
                            child: const Text(
                              "Да, точно",
                              style: TextStyle(color: Colors.white),
                            )),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Нет, остаться",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            },
            child: const Text(
              'Выйти',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
          ),
          Text(widget.token1.getString('token')!),
        ],
      ),
    );
  }
}
