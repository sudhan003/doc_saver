import 'package:doc_saver/all_imports.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _navigate() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      bool value = FirebaseAuth.instance.currentUser == null;
      if (value) {
        print(value);
        Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
      } else {
        print(FirebaseAuth.instance.currentUser!.email);
        print(FirebaseAuth.instance.currentUser!.uid);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    });
  }

  @override
  void initState() {
    _navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/auth_image.png',
              height: 150,
            ),
            Image.asset(
              'assets/app_logo.png',
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
