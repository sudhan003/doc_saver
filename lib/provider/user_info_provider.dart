import 'package:doc_saver/all_imports.dart';

class UserInfoProvider extends ChangeNotifier {
  String _userName = "";

  String get userName => _userName;
  String _userEmail = '';

  String get userEmail => _userEmail;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  getUserInfo() async {
    await FirebaseDatabase.instance
        .ref()
        .child('user_info/$userId')
        .get()
        .then((value) {
      _userName = (value.value as Map)['userName'].toString();
      _userEmail = (value.value as Map)['userEmail'].toString();
      notifyListeners();
    });
  }

  updateUserName(String userName, BuildContext context) async {
    await FirebaseDatabase.instance
        .ref()
        .child('user_info/$userId')
        .update({'userName': userName}).then((value) {
      _userName = userName;
      notifyListeners();
      Navigator.of(context).pop();
    });
  }
}
