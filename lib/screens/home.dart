import 'package:flutter/material.dart';
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
          Image.asset('assets/sign_in/launch_image.png'),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Выйти',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          Text(widget.token1.getString('token')!),
        ],
      ),
    );
  }
}
