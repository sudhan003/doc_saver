import 'package:doc_saver/all_imports.dart';

class AddFileScreen extends StatelessWidget {
  static String routeName = '/addFileScreen';

  AddFileScreen({super.key});

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<DocumentProvider>(context, listen: false);
    return SafeArea(
      child: Form(
        key: _key,
        child: Scaffold(
          floatingActionButton:
              Consumer<DocumentProvider>(builder: (context, provider, _) {
            return provider.isFileUploading
                ? const CircularProgressIndicator()
                : CustomFloatingActionButton(
                    title: 'Upload',
                    iconData: Icons.check,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (_key.currentState!.validate()) {
                        provider.sendDocumentData(context: context);
                      }
                    },
                  );
          }),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1e5376),
            title: const Text(
              'Add File',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: ScreenBackgroundWidget(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Consumer<DocumentProvider>(builder: (context, provider, _) {
                    return CustomTextField(
                        controller: _provider.titleController,
                        labelText: 'Title',
                        hintText: 'Enter the title',
                        prefixIconData: Icons.title,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter the title";
                          } else {
                            return null;
                          }
                        });
                  }),
                  SizedBoxHelper.sizedBox10,
                  Consumer<DocumentProvider>(builder: (context, provider, _) {
                    return CustomTextField(
                        controller: _provider.noteController,
                        hintText: 'Enter the notes',
                        labelText: 'Notes',
                        prefixIconData: Icons.note,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter the notes";
                          } else {
                            return null;
                          }
                        });
                  }),
                  SizedBoxHelper.sizedBox10,
                  InkWell(
                    onTap: () {
                      _provider.pickFile(context);
                    },
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.5)),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer<DocumentProvider>(
                                builder: (context, provider, _) {
                              return Text(provider.selectedFileName);
                            }),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add),
                                Text('Upload File'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
