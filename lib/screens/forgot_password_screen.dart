import 'package:doc_saver/all_imports.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = '/forgotPasswordScreenroute';

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackgroundWidget(
        child: ListView(
          children: [
            SizedBoxHelper.sizedBox100,
            Image.asset(
              'assets/auth_image.png',
              height: 150,
            ),
            SizedBoxHelper.sizedBox30,
            const Text(
              'Enter you email to reset your password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBoxHelper.sizedBox10,
            Form(
              key: _key,
              child: CustomTextField(
                controller: emailController,
                hintText: 'Enter your email',
                labelText: 'Email',
                prefixIconData: Icons.email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ),
            SizedBoxHelper.sizedBox20,
            Consumer<AuthProvider>(builder: (context, provider, _) {
              return provider.isLoadingForgotPassword
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          provider.forgotPassword(
                              context, emailController.text);
                        }
                      },
                      title: 'Verify email',
                    );
            }),
            SizedBoxHelper.sizedBox20,
          ],
        ),
      ),
    );
  }
}
