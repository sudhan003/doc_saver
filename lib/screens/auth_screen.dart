import 'package:doc_saver/all_imports.dart';

class AuthScreen extends StatefulWidget {
  static String routeName = '/authScreen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController =
      TextEditingController(text: 'sudhan@abc.com');
  TextEditingController passwordController =
      TextEditingController(text: '987654321');
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();
  String? password;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: Form(
          key: _key,
          child: ScreenBackgroundWidget(
            child: ListView(
              children: [
                Image.asset(
                  'assets/auth_image.png',
                  height: 150,
                ),
                SizedBoxHelper.sizedBox30,
                if (!provider.isLogin) // if the isLogin value is false
                  CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your username";
                      } else {
                        return null;
                      }
                    },
                    controller: userNameController,
                    hintText: 'Username',
                    labelText: 'Enter your username',
                    prefixIconData: Icons.person,
                  ),
                SizedBoxHelper.sizedBox20,
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  hintText: 'Email',
                  labelText: 'Enter your email',
                  prefixIconData: Icons.email,
                ),
                SizedBoxHelper.sizedBox20,
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return "Please enter valid password";
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  hintText: 'Password',
                  labelText: 'Enter your password',
                  prefixIconData: Icons.key,
                  sufixIconData: provider.isObsecurePassword
                      ? IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {
                            provider.setObsecurePassword();
                          },
                        )
                      : IconButton(
                          onPressed: () {
                            provider.setObsecurePassword();
                          },
                          icon: const Icon(Icons.visibility_off),
                        ),
                  obscureText: provider.isObsecurePassword,
                ),
                SizedBoxHelper.sizedBox20,
                if (!provider.isLogin)
                  CustomTextField(
                    validator: (value) {
                      if (passwordController.text.length >= 6) {
                        if (value != passwordController.text) {
                          return "Password does not match";
                        } else if (value!.isEmpty) {
                          return 'Please enter the password';
                        } else {
                          return null;
                        }
                      } else {
                        return null;
                      }
                    },
                    controller: confirmPasswordController,
                    hintText: 'Confirm password',
                    labelText: 'Re-enter your password',
                    prefixIconData: Icons.key,
                    sufixIconData: provider.isObsecureConfirmPassword
                        ? IconButton(
                            icon: const Icon(Icons.visibility_off),
                            onPressed: () {
                              provider.setObsecureConfirmPassword();
                            },
                          )
                        : IconButton(
                            onPressed: () {
                              provider.setObsecureConfirmPassword();
                            },
                            icon: const Icon(Icons.visibility),
                          ),
                    obscureText: provider.isObsecureConfirmPassword,
                  ),
                SizedBoxHelper.sizedBox20,
                provider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            if (provider.isLogin) {
                              provider.signIn(
                                context,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            } else {
                              provider.signUp(
                                context,
                                email: emailController.text,
                                password: passwordController.text,
                                username: userNameController.text,
                              );
                            }
                          }
                        },
                        title: provider.isLogin ? 'Login' : 'Register',
                      ),
                MaterialButton(
                  onPressed: () {
                    provider.setLogin();
                  },
                  child: provider.isLogin
                      ? const Text(
                          "Don't have an account ? Signup",
                        )
                      : const Text(
                          'Already have an account? login',
                        ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ForgotPasswordScreen.routeName);
                  },
                  child: const Text(
                    'Forget password?',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
