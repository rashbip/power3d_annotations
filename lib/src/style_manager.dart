import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:power3d/power3d.dart';
import 'enum.dart';

class Power3DAnnotationProvider {
  static const String _libDirName = 'power3d_assets';

  /// Ensures the specified [style] is copied to the power3d assets directory.
  /// Returns the relative path for JavaScript to load (e.g. 'js/annotation/styles/hotspot.js').
  static Future<String> useStyle(Power3DAnnotationStyle style) async {
    // If it's the built-in tooltip, it's already in the core zip/assets
    if (style == Power3DAnnotationStyle.tooltip) {
      return 'js/annotation/styles/tooltip.js';
    }

    final appDir = await getApplicationSupportDirectory();
    final targetStylesDir = Directory(
      p.join(appDir.path, _libDirName, 'js', 'annotation', 'styles'),
    );

    debugPrint(
      'Power3DAnnotationProvider: Checking target: ${targetStylesDir.path}',
    );

    if (!await targetStylesDir.exists()) {
      debugPrint(
        'Power3DAnnotationProvider: ERROR - Core styles folder NOT FOUND. Is Power3D initialized?',
      );
      throw Exception(
        'Power3D styles directory missing. Ensure the 3D viewer has loaded before trying to switch styles from this plugin.',
      );
    }

    final outFile = File(p.join(targetStylesDir.path, style.fileName));
    debugPrint('Power3DAnnotationProvider: Copying style "${style.name}"...');

    try {
      final data = await rootBundle.load(style.assetPath);
      final bytes = data.buffer.asUint8List();
      await outFile.writeAsBytes(bytes);
      debugPrint('Power3DAnnotationProvider: SUCCESS copied ${style.fileName}');
    } catch (e) {
      debugPrint(
        'Power3DAnnotationProvider: FATAL - Could not load ${style.assetPath} from bundle.',
      );
      debugPrint('Power3DAnnotationProvider: Details: $e');
      rethrow;
    }

    return 'js/annotation/styles/${style.fileName}';
  }
}

/// Extension to provide easy style switching with the enum
extension AnnotationControllerExt on Power3DController {
  /// Initializes the controller for use with the [power3d_annotations] plugin.
  /// Call this once after creating the controller to support Enums in the widget.
  void initForAnnotations() {
    onResolveStyle = (s) => setAnnotationStyleEnum(s as Power3DAnnotationStyle);
  }

  /// Sets the annotation style using the [Power3DAnnotationStyle] enum.
  /// This automatically provisions the style file to the viewer's directory.
  Future<void> setAnnotationStyleEnum(Power3DAnnotationStyle style) async {
    // If hook is not set, set it now to enable automatic widget support
    onResolveStyle ??= (s) =>
        setAnnotationStyleEnum(s as Power3DAnnotationStyle);

    final path = await Power3DAnnotationProvider.useStyle(style);
    setAnnotationStyle(path);
  }
}
