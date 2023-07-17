import 'package:doc_saver/all_imports.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final IconData prefixIconData;
  final Widget? sufixIconData;
  final String? Function(String?)? validator;
  final bool? obscureText;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.labelText,
      required this.prefixIconData,
      this.sufixIconData,
      required this.validator,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextFormField(
        obscureText: obscureText!,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: Icon(prefixIconData),
          suffixIcon: sufixIconData,
        ),
      ),
    );
  }
}
