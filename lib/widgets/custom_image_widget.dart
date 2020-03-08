import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/data/network/constants/endpoints.dart';
import 'package:quiver/strings.dart';

class CustomImageWidget extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double width;
  final double height;
  final String missingPhoto;
  final String placeholder;
  final bool animated;

  const CustomImageWidget(
      {Key key,
      @required this.url,
      this.width,
      this.height,
      this.fit,
      this.missingPhoto = 'assets/images/ic_no_image.png',
      this.placeholder,
      this.animated = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var missingWidget = Image.asset(
      missingPhoto,
      width: width ?? 100,
      height: height ?? 100,
    );

    if (isBlank(url)) {
      return missingWidget;
    }
    if (animated)
      return CachedNetworkImage(
        imageUrl: _getUrl(url),
        width: width,
        height: height,
        errorWidget: (_, __, ___) => missingWidget,
        fit: fit,
      );
    return Image(
      image: CachedNetworkImageProvider(url),
      width: width,
      height: height,
      fit: fit,
    );
  }

  static String _getUrl(String url) {
    if (url.startsWith('http')) return url;
    return '${Endpoints.basePhotoUrl}$url';
  }
}
