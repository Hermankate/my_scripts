//import 'package:starflut/starflut.dart';

class PythonService {
  static Future<String> downloadYouTubeVideo(String link, String savePath) async {
    try {
      Initialize StarFlut
      StarCoreFactory? starCoreFactory = await Starflut.getFactory();
      StarService? starService = await starCoreFactory.initSimple("test", "123", 0, 0, []);
      StarSrvGroupClass? starGroup = await starService.getSrvGroup();

      // Load Python Environment
      await starGroup.initRaw();
      var python = await starGroup.importRawContext("", "python");
      await python.loadModule("sys");
      await python.runScriptString("sys.path.append('./assets')");

      // Import and Call the Python Script
      var downloader = await python.importModule("yt_downloader");
      var result = await downloader.call("download_video", [link, savePath]);

      return result;
    } catch (e) {
      return "Error: $e";
    }
  }
}
