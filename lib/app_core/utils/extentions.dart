import 'package:flutter/material.dart';

extension ImagePreloadExtention on Image {
  void preload({
    VoidCallback? onImageLoaded,
    VoidCallback? onError,
  }) {
    image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool syncCall) {
          onImageLoaded?.call();
        }, onError: (Object exception, StackTrace? stackTrace) {
          onError?.call();
        }));
  }
}

extension PreloadImageProviderExtension on ImageProvider {
  void preload({
    VoidCallback? onImageLoaded,
    VoidCallback? onError,
  }) {
    resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool syncCall) {
          onImageLoaded?.call();
        }, onError: (Object exception, StackTrace? stackTrace) {
          onError?.call();
        }));
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
