import 'package:doc_saver/all_imports.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  bool _isLogin = true;

  bool get isLogin => _isLogin;

  setLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  bool _isObsecurePassword = true;

  bool get isObsecurePassword => _isObsecurePassword;

  setObsecurePassword() {
    _isObsecurePassword = !_isObsecurePassword;
    notifyListeners();
  }

  bool _isObsecureConfirmPassword = true;

  bool get isObsecureConfirmPassword => _isObsecureConfirmPassword;

  setObsecureConfirmPassword() {
    _isObsecureConfirmPassword = !_isObsecureConfirmPassword;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  signUp(BuildContext context,
      {required String email,
      required String password,
      required String username}) async {
    try {
      setIsLoading(true);
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        _firebaseDatabase
            .ref()
            .child('user_info/${value.user!.uid}')
            .set({'userName': username, 'userEmail': email});
        SnackBarHelper.showSnackBar(
            context, 'Sign up successfully completed', Colors.greenAccent);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        return value;
      });
      print(userCredential.user?.uid.toString());
      setIsLoading(false);
    } on FirebaseAuthException catch (firebaseAuthError) {
      setIsLoading(false);
      SnackBarHelper.showSnackBar(
          context, firebaseAuthError.message!, Colors.redAccent);
      print(firebaseAuthError.message);
    } catch (error) {
      setIsLoading(false);
      SnackBarHelper.showSnackBar(context, error.toString(), Colors.redAccent);

      print(error.toString());
    }
  }

  signIn(BuildContext context,
      {required String email, required String password}) async {
    try {
      setIsLoading(true);
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SnackBarHelper.showSnackBar(
            context, 'Sign in successfully completed', Colors.greenAccent);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        return value;
      });
      print(userCredential.user?.uid.toString());
      setIsLoading(false);
    } on FirebaseAuthException catch (firebaseAuthError) {
      setIsLoading(false);
      SnackBarHelper.showSnackBar(
          context, firebaseAuthError.message!, Colors.redAccent);
      print(firebaseAuthError.message);
    } catch (error) {
      setIsLoading(false);
      SnackBarHelper.showSnackBar(context, error.toString(), Colors.redAccent);

      print(error.toString());
    }
  }

  bool _isLoadingForgotPassword = false;

  bool get isLoadingForgotPassword => _isLoadingForgotPassword;

  setIsLoadingForgotPassword(bool value) {
    _isLoadingForgotPassword = value;
    notifyListeners();
  }

  forgotPassword(BuildContext context, String email) async {
    try {
      setIsLoadingForgotPassword(true);
      UserCredential userCredential = await _firebaseAuth
          .sendPasswordResetEmail(email: email)
          .then((value) => SnackBarHelper.showSnackBar(context,
              'Password reset link sent to $email', Colors.greenAccent));
      setIsLoadingForgotPassword(false);
    } on FirebaseAuthException catch (firebaseAuthError) {
      setIsLoadingForgotPassword(false);
      SnackBarHelper.showSnackBar(
          context, firebaseAuthError.message!, Colors.redAccent);
      print(firebaseAuthError.message);
    } catch (error) {
      setIsLoadingForgotPassword(false);
      SnackBarHelper.showSnackBar(context, error.toString(), Colors.redAccent);

      print(error.toString());
    }
  }

  bool _isLoadingLogOut = false;

  bool get isLoadingLogOut => _isLoadingLogOut;

  setIsLoadingLogOut(bool value) {
    _isLoadingLogOut = value;
    notifyListeners();
  }

  logOut(BuildContext context) async {
    try {
      setIsLoadingLogOut(true);
      await _firebaseAuth.signOut().then((value) {
        setIsLoadingLogOut(false);
        SnackBarHelper.showSnackBar(
            context, 'Logout successful', Colors.greenAccent);
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacementNamed(context, AuthScreen.routeName);
      });
    } on FirebaseAuthException catch (firebaseAuthError) {
      setIsLoadingLogOut(false);
      SnackBarHelper.showSnackBar(
          context, firebaseAuthError.message!, Colors.redAccent);
      print(firebaseAuthError.message);
    } catch (error) {
      setIsLoadingLogOut(false);
      SnackBarHelper.showSnackBar(context, error.toString(), Colors.redAccent);
    }
  }
}
