import 'package:doc_saver/all_imports.dart';

class SettingScreen extends StatelessWidget {
  static String routeName = '/settingScreen';

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1e5376),
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer<UserInfoProvider>(builder: (context, provider, _) {
              provider.getUserInfo();
              TextEditingController controller = TextEditingController();
              return SettingCard(
                title: provider.userName,
                leadingIcon: Icons.person,
                trailingWidget: IconButton(
                  onPressed: () {
                    // provider.updateUserName('sudhan003');
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom *
                                          0.9),
                              child: SizedBox(
                                height: 250,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Update Username',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      SizedBoxHelper.sizedBox20,
                                      CustomTextField(
                                          controller: controller,
                                          hintText: 'Enter new username',
                                          prefixIconData: Icons.person,
                                          validator: null),
                                      SizedBoxHelper.sizedBox10,
                                      CustomButton(
                                          onPressed: () {
                                            provider.updateUserName(
                                                controller.text, context);
                                          },
                                          title: 'Update username')
                                    ],
                                  ),
                                ),
                              ),
                            ));
                  },
                  icon: const Icon(Icons.edit),
                ),
              );
            }),
            Consumer<UserInfoProvider>(builder: (context, provider, _) {
              return SettingCard(
                title: provider.userEmail,
                leadingIcon: Icons.mail,
              );
            }),
            InkWell(
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .logOut(context);
              },
              child: const SettingCard(
                title: 'logout',
                leadingIcon: Icons.logout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
