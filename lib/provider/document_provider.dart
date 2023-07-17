import 'package:doc_saver/all_imports.dart';

class DocumentProvider extends ChangeNotifier {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  File? _file;
  String _selectedFileName = "";

  String get selectedFileName => _selectedFileName;

  setSelectedFileName(value) {
    _selectedFileName = value;
    notifyListeners();
  }

  pickFile(BuildContext context) async {
    await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'mp3']).then((result) {
      if (result != null) {
        PlatformFile selectedFile = result.files.first;
        _file = File(selectedFile.path!);
        setSelectedFileName(selectedFile.name);
        print(selectedFile.name);
      } else {
        SnackBarHelper.showSnackBar(context, 'no file selected', Colors.red);
      }
    });
  }

  bool _isFileUploading = false;

  bool get isFileUploading => _isFileUploading;

  setIsFileUploading(bool value) {
    _isFileUploading = value;
    notifyListeners();
  }

  resetAll() {
    titleController = TextEditingController();
    noteController = TextEditingController();
    _selectedFileName = "";
    _file = null;
  }

  String userId = FirebaseAuth.instance.currentUser!.uid;

  sendDocumentData({required BuildContext context}) async {
    setIsFileUploading(true);
    try {
      UploadTask uploadTask = _firebaseStorage
          .ref()
          .child('files')
          .child(_selectedFileName)
          .putFile(_file!);
      print('upload task is ${await uploadTask}');
      TaskSnapshot taskSnapshot = await uploadTask;
      print('task snapshot $taskSnapshot.toString()');
      String uploadedFileUrl = await taskSnapshot.ref.getDownloadURL();
      print(uploadedFileUrl);

      await _firebaseDatabase.ref().child('files_info/$userId').push().set({
        'title': titleController.text,
        'note': noteController.text,
        'date': DateTime.now().toString(),
        'fileUrl': uploadedFileUrl,
        'fileName': _selectedFileName,
        'fileType': _selectedFileName.split('.').last
      });
      resetAll();
      setIsFileUploading(false);
    } on FirebaseException catch (firebaseError) {
      setIsFileUploading(false);
      SnackBarHelper.showSnackBar(context, firebaseError.message!, Colors.red);
    } catch (e) {
      setIsFileUploading(false);
      SnackBarHelper.showSnackBar(context, e.toString(), Colors.red);
    }
  }

  deleteDocument(BuildContext context, String id) {
    _firebaseStorage.ref().child('files').child(_selectedFileName).delete();
    _firebaseDatabase.ref().child('files_info/$userId/$id').remove();
  }
}
