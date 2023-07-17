import 'package:doc_saver/all_imports.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function() onTap;

  const CustomFloatingActionButton(
      {super.key,
      required this.title,
      required this.iconData,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(05),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 2,
              )
            ]),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
