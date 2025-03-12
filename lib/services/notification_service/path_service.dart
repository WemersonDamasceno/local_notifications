import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// Implementação do serviço de manipulação de arquivos
class PathService {
  static Future<String?> downloadAndSaveFile(
      String? url, String fileName) async {
    try {
      if (url == null) return null;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Directory tempDir = await getTemporaryDirectory();
        final File file = File('${tempDir.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        return file.path;
      }
    } catch (e) {
      print('Erro ao baixar a imagem: $e');
    }
    return null;
  }
}
