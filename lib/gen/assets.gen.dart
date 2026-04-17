// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/deco_yelow.svg
  String get decoYelow => 'assets/images/deco_yelow.svg';

  /// File path: assets/images/elips.svg
  String get elips => 'assets/images/elips.svg';

  /// File path: assets/images/logo_with_label.svg
  String get logoWithLabel => 'assets/images/logo_with_label.svg';

  /// File path: assets/images/person.svg
  String get person => 'assets/images/person.svg';

  /// Directory path: assets/images/providers
  $AssetsImagesProvidersGen get providers => const $AssetsImagesProvidersGen();

  /// File path: assets/images/smiley-man-with-old-phone 1.png
  AssetGenImage get smileyManWithOldPhone1 =>
      const AssetGenImage('assets/images/smiley-man-with-old-phone 1.png');

  /// List of all assets
  List<dynamic> get values => [
    decoYelow,
    elips,
    logoWithLabel,
    person,
    smileyManWithOldPhone1,
  ];
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/logo.svg
  String get logo => 'assets/logo/logo.svg';

  /// List of all assets
  List<String> get values => [logo];
}

class $AssetsImagesProvidersGen {
  const $AssetsImagesProvidersGen();

  /// File path: assets/images/providers/mixx.png
  AssetGenImage get mixx =>
      const AssetGenImage('assets/images/providers/mixx.png');

  /// File path: assets/images/providers/orange_money.png
  AssetGenImage get orangeMoney =>
      const AssetGenImage('assets/images/providers/orange_money.png');

  /// File path: assets/images/providers/wave.png
  AssetGenImage get wave =>
      const AssetGenImage('assets/images/providers/wave.png');

  /// List of all assets
  List<AssetGenImage> get values => [mixx, orangeMoney, wave];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
