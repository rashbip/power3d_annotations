/// Defines the available visual styles for annotations.
enum Power3DAnnotationStyle {
  /// A standard tooltip that stays near the anchor point.
  tooltip,
  /// A modern text callout that can include titles and expandable descriptions.
  textcallout,
  /// A minimal dot/hotspot that expands into a data card when clicked.
  hotspot;

  String get fileName => '$name.js';
  String get assetPath => 'packages/power3d_annotations/assets/styles/$fileName';
}
