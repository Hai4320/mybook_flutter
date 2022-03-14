import 'package:flutter/material.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/transparent_appbar.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class BookPDF extends StatefulWidget {
  const BookPDF({Key? key, required this.pdf}) : super(key: key);
  final String pdf;

  @override
  State<BookPDF> createState() => _BookPDFState();
}

class _BookPDFState extends State<BookPDF> {
  final _key = UniqueKey();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar("Read Book",AppColors.primary),
      body: WebView(
        key: _key,
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.pdf,
      ),
    );
  }
}
