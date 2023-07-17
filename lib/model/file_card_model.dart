class FileCardModel {
  final String title;
  final String subTitle;
  final String date;
  final String fileName;
  final String fileType;
  final String fileUrl;
  final String id;

  FileCardModel(
      {required this.id,
      required this.fileName,
      required this.title,
      required this.subTitle,
      required this.date,
      required this.fileUrl,
      required this.fileType});

  factory FileCardModel.fromJson(Map<dynamic, dynamic> json, String id) {
    return FileCardModel(
        id: id,
        title: json['title'].toString(),
        subTitle: json['note'].toString(),
        date: json['date'].toString().split(' ').first,
        fileUrl: json['fileUrl'].toString(),
        fileType: json['fileType'].toString(),
        fileName: json['fileName'].toString());
  }
}
