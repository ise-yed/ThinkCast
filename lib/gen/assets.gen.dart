/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/hashtag.png
  AssetGenImage get hashtag => const AssetGenImage('assets/icons/hashtag.png');

  /// File path: assets/icons/home.png
  AssetGenImage get home => const AssetGenImage('assets/icons/home.png');

  /// File path: assets/icons/logo.svg
  String get logo => 'assets/icons/logo.svg';

  /// File path: assets/icons/morepodcast.png
  AssetGenImage get morepodcast =>
      const AssetGenImage('assets/icons/morepodcast.png');

  /// File path: assets/icons/moretext.png
  AssetGenImage get moretext =>
      const AssetGenImage('assets/icons/moretext.png');

  /// File path: assets/icons/profile.png
  AssetGenImage get profile => const AssetGenImage('assets/icons/profile.png');

  /// File path: assets/icons/write.png
  AssetGenImage get write => const AssetGenImage('assets/icons/write.png');

  /// List of all assets
  List<dynamic> get values =>
      [hashtag, home, logo, morepodcast, moretext, profile, write];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ProfileImage.png
  AssetGenImage get profileImage =>
      const AssetGenImage('assets/images/ProfileImage.png');

  /// File path: assets/images/addmusic.png
  AssetGenImage get addmusic =>
      const AssetGenImage('assets/images/addmusic.png');

  /// File path: assets/images/arrowDownCompletePage.png
  AssetGenImage get arrowDownCompletePage =>
      const AssetGenImage('assets/images/arrowDownCompletePage.png');

  /// File path: assets/images/d.svg
  String get d => 'assets/images/d.svg';

  /// File path: assets/images/fhchch.svg
  String get fhchch => 'assets/images/fhchch.svg';

  /// File path: assets/images/happytech.svg
  String get happytech => 'assets/images/happytech.svg';

  /// File path: assets/images/kkk.svg
  String get kkk => 'assets/images/kkk.svg';

  /// File path: assets/images/lll.svg
  String get lll => 'assets/images/lll.svg';

  /// File path: assets/images/logo.svg
  String get logo => 'assets/images/logo.svg';

  /// File path: assets/images/manage_article.png
  AssetGenImage get manageArticle =>
      const AssetGenImage('assets/images/manage_article.png');

  /// File path: assets/images/manage_podcasts.png
  AssetGenImage get managePodcasts =>
      const AssetGenImage('assets/images/manage_podcasts.png');

  /// File path: assets/images/podcasts.jpg
  AssetGenImage get podcasts =>
      const AssetGenImage('assets/images/podcasts.jpg');

  /// File path: assets/images/poster.png
  AssetGenImage get poster => const AssetGenImage('assets/images/poster.png');

  /// File path: assets/images/poster2.jpg
  AssetGenImage get poster2 => const AssetGenImage('assets/images/poster2.jpg');

  /// File path: assets/images/sadtech.svg
  String get sadtech => 'assets/images/sadtech.svg';

  /// File path: assets/images/tcbotsad.png
  AssetGenImage get tcbotsad =>
      const AssetGenImage('assets/images/tcbotsad.png');

  /// File path: assets/images/ugkug.svg
  String get ugkug => 'assets/images/ugkug.svg';

  /// File path: assets/images/whitelogo.jpg
  AssetGenImage get whitelogo =>
      const AssetGenImage('assets/images/whitelogo.jpg');

  /// File path: assets/images/whitelogos.jpg
  AssetGenImage get whitelogos =>
      const AssetGenImage('assets/images/whitelogos.jpg');

  /// List of all assets
  List<dynamic> get values => [
        profileImage,
        addmusic,
        arrowDownCompletePage,
        d,
        fhchch,
        happytech,
        kkk,
        lll,
        logo,
        manageArticle,
        managePodcasts,
        podcasts,
        poster,
        poster2,
        sadtech,
        tcbotsad,
        ugkug,
        whitelogo,
        whitelogos
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

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
