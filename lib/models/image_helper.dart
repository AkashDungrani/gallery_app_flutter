import 'dart:ffi';

class Photos {
  final String preview;
  final String largeimage;
  final int preheight;
  final int prewidth;

  Photos({
    required this.preview,
    required this.largeimage,
    required this.preheight,
    required this.prewidth,
  });
  factory Photos.fromMap({required Map<String, dynamic> data}) {
    return Photos(
        preview: data["previewURL"], largeimage: data["largeImageURL"],preheight: data["previewHeight"],
        prewidth: data["previewWidth"]);
  }
}
