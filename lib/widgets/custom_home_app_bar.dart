import 'package:doc_saver/all_imports.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const CustomHomeAppBar(
      {super.key, required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(150),
      child: Container(
        color: const Color(0xFF1e5376),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/app_logo.png',
                      width: 150,
                    ),
                    IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.of(context)
                            .pushNamed(SettingScreen.routeName);
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBoxHelper.sizedBox20,
                CustomTextField(
                  controller: controller,
                  hintText: 'Please enter the title to  search',
                  prefixIconData: Icons.search,
                  validator: (value) {
                    return null;
                  },
                  sufixIconData: IconButton(
                    onPressed: onSearch,
                    icon: const Text(
                      'Go',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
