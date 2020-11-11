// import 'dart:io';

// import 'package:note/services/FileContract.dart';
// import 'package:path_provider/path_provider.dart';

// class FileService implements FileContract {
//   @override
//   Future getPath() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     return directory.path;
//   }

//   @override
//   Future createFile() async {
//     final file = await getPath();
//     return File('$file/notes.txt').existsSync();
//   }

//   @override
//   Future<bool> writeFile(String data) async {
//     try {
//       final file = await createFile();
//       file.writeAsString(data);
//       return true;
//     } catch (e) {
//       print(e.toString());
//       return false;
//     }
//   }

//   @override
//   Future<String> readFile() async {
//     try {
//       final file = await createFile();
//       String contents = await file.readAsString();
//       return contents;
//     } catch (e) {
//       print(e.toString());
//       return '';
//     }
//   }
// }
