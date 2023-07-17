import 'package:doc_saver/all_imports.dart';

class FileCard extends StatelessWidget {
  final FileCardModel model;

  const FileCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                spreadRadius: 4,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  model.fileType == 'pdf'
                      ? Image.asset(
                          "assets/icons/icon_pdf_type.png",
                          width: 50,
                        )
                      : Image.asset(
                          "assets/icons/icon_image_type.png",
                          width: 50,
                        ),
                  SizedBoxHelper.sizedBox_5,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          model.subTitle,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'Date added: ${model.date}',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<DocumentProvider>(context, listen: false)
                          .deleteDocument(context, model.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DocumentViewScreen.routeName,
                        arguments: DocumentViewScreenArgs(
                          fileName: model.fileName,
                          fileUrl: model.fileUrl,
                          fileType: model.fileType,
                        ),
                      );
                    },
                    child: Text(
                      'View',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.blue,
                          ),
                    ),
                  ),
                  SizedBoxHelper.sizedBox_5,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
