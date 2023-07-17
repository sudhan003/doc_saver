import 'package:doc_saver/all_imports.dart';

class SettingCard extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final Widget? trailingWidget;

  const SettingCard(
      {super.key,
      required this.title,
      required this.leadingIcon,
      this.trailingWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              spreadRadius: 4,
            )
          ]),
          child: ListTile(
            leading: Icon(leadingIcon),
            title: Text(title),
            trailing: trailingWidget,
          )),
    );
  }
}
