enum Power3DAnnotationStyle {
  tooltip,
  textcallout,
  hotspot;

  String get fileName => '$name.js';
  String get assetPath => 'packages/power3d_annotations/assets/styles/$fileName';
}
