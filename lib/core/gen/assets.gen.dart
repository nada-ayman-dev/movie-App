/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/onboarding1.png
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/onboarding1.png');

  /// File path: assets/images/onboarding1_1.png
  AssetGenImage get onboarding11 =>
      const AssetGenImage('assets/images/onboarding1_1.png');

  /// File path: assets/images/onboarding2.png
  AssetGenImage get onboarding2 =>
      const AssetGenImage('assets/images/onboarding2.png');

  /// File path: assets/images/onboarding2_2.png
  AssetGenImage get onboarding22 =>
      const AssetGenImage('assets/images/onboarding2_2.png');

  /// File path: assets/images/onboarding3.png
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/images/onboarding3.png');

  /// File path: assets/images/onboarding3_3.png
  AssetGenImage get onboarding33 =>
      const AssetGenImage('assets/images/onboarding3_3.png');

  /// File path: assets/images/onboarding4.png
  AssetGenImage get onboarding4 =>
      const AssetGenImage('assets/images/onboarding4.png');

  /// File path: assets/images/onboarding4_4.png
  AssetGenImage get onboarding44 =>
      const AssetGenImage('assets/images/onboarding4_4.png');

  /// File path: assets/images/onboarding5.png
  AssetGenImage get onboarding5 =>
      const AssetGenImage('assets/images/onboarding5.png');

  /// File path: assets/images/onboarding5_5.png
  AssetGenImage get onboarding55 =>
      const AssetGenImage('assets/images/onboarding5_5.png');

  /// File path: assets/images/onboarding6.png
  AssetGenImage get onboarding6 =>
      const AssetGenImage('assets/images/onboarding6.png');

  /// File path: assets/images/onboarding6_6.png
  AssetGenImage get onboarding66 =>
      const AssetGenImage('assets/images/onboarding6_6.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        onboarding1,
        onboarding11,
        onboarding2,
        onboarding22,
        onboarding3,
        onboarding33,
        onboarding4,
        onboarding44,
        onboarding5,
        onboarding55,
        onboarding6,
        onboarding66
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
