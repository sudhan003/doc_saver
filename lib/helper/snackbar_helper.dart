import 'package:doc_saver/all_imports.dart';

class SnackBarHelper {
  static showSnackBar(BuildContext context, String message, Color colorName) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: colorName,
    ));
  }
}
