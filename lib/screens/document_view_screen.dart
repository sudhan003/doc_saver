import 'package:doc_saver/all_imports.dart';

class DocumentViewScreen extends StatelessWidget {
  static String routeName = '/documentScreenView';

  const DocumentViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DocumentViewScreenArgs;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1e5376),
          title: Text(args.fileName),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return args.fileType == 'pdf'
                    ? PdfView(path: snapshot.data!)
                    : Image.file(File(snapshot.data!));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            future: getDocumentData(args),
          ),
        ));
  }
}

Future<String> getDocumentData(
    DocumentViewScreenArgs documentViewScreenArgs) async {
  Directory directory = await getApplicationSupportDirectory();
  File file = File('${directory.path}/${documentViewScreenArgs.fileName}');
  print(file.path);
  if (await file.exists()) {
    print('file exists');
    return file.path;
  } else {
    final response = await get(Uri.parse(documentViewScreenArgs.fileUrl));

    await file.writeAsBytes(response.bodyBytes);
    print('file downloaded');
    return file.path;
  }
}

class DocumentViewScreenArgs {
  final String fileName;
  final String fileUrl;
  final String fileType;

  DocumentViewScreenArgs({
    required this.fileName,
    required this.fileUrl,
    required this.fileType,
  });
}
