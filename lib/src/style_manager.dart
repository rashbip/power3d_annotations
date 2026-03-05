import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'enum.dart';

class Power3DAnnotationProvider {
  static const String _libDirName = 'power3d_assets';

  /// Ensures the specified [style] is copied to the power3d assets directory.
  /// Returns the relative path for JavaScript to load (e.g. 'js/annotation/styles/hotspot.js').
  static Future<String> useStyle(Power3DAnnotationStyle style) async {
    final appDir = await getApplicationSupportDirectory();
    final targetStylesDir = Directory(
      p.join(appDir.path, _libDirName, 'js', 'annotation', 'styles'),
    );

    if (!await targetStylesDir.exists()) {
      await targetStylesDir.create(recursive: true);
    }

    final outFile = File(p.join(targetStylesDir.path, style.fileName));

    // Always copy to ensure we have the latest version from the plugin
    try {
      final data = await rootBundle.load(style.assetPath);
      final bytes = data.buffer.asUint8List();
      await outFile.writeAsBytes(bytes);
    } catch (e) {
      throw Exception('Failed to load annotation style asset: ${style.assetPath}. Error: $e');
    }

    return 'js/annotation/styles/${style.fileName}';
  }
}
