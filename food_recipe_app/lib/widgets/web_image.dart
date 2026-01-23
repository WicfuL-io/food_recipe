import 'dart:ui_web' as ui;
import 'package:flutter/widgets.dart';
import 'package:universal_html/html.dart' as html;

class WebImage extends StatelessWidget {
  final String url;
  final double? height;

  const WebImage(
    this.url, {
    super.key,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      url,
      (int viewId) {
        final img = html.ImageElement()
          ..src = url
          ..style.width = '100%'
          ..style.height = height != null ? '${height}px' : '100%'
          ..style.objectFit = 'cover';

        return img;
      },
    );

    return SizedBox(
      height: height,
      width: double.infinity,
      child: HtmlElementView(viewType: url),
    );
  }
}
