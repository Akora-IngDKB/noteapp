import 'dart:io';

import 'package:note/services/FileContract.dart';
import 'package:path_provider/path_provider.dart';

class FileService implements FileContract {
  String texts;

  @override
  Future getPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Future<File> createFile() async {
    final file = await getPath();
    return File('$file/notes.txt');
  }

  @override
  Future<File> writeFile(String data) async {
    final file = await createFile();
    return file.writeAsString(data);
  }

  @override
  Future readFile() async {
    try {
      final file = await createFile();
      String contents = await file.readAsString();
      texts = contents;
      print(texts);
      return texts.toString();
    } catch (e) {
      print(e.toString());
    }
  }
}
