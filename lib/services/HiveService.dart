import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HiveService {
  Future initHive() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      Directory directory = await getApplicationDocumentsDirectory();
      Hive.init(directory.path);
      await Hive.openBox('notes');
    }
  }
}
