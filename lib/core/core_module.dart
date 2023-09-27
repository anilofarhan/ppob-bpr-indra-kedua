import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class CoreModule {
  static Future<void> init() async {
    var appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
  }
}
