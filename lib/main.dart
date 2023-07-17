import 'package:doc_saver/all_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DocumentProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserInfoProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
          ),
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          AuthScreen.routeName: (context) => const AuthScreen(),
          ForgotPasswordScreen.routeName: (context) =>
              const ForgotPasswordScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          AddFileScreen.routeName: (context) => AddFileScreen(),
          SettingScreen.routeName: (context) => const SettingScreen(),
          DocumentViewScreen.routeName: (context) => const DocumentViewScreen(),
          SplashScreen.routeName: (context) => const SplashScreen(),
        },
      ),
    );
  }
}
