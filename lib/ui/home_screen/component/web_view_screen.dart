// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewScreen extends StatefulWidget {
//   const WebViewScreen({Key? key}) : super(key: key);
//
//   @override
//   _WebViewScreenState createState() => _WebViewScreenState();
// }
//
// class _WebViewScreenState extends State<WebViewScreen> {
//
//   @override
//   void initState() {
//     if (Platform.isAndroid) WebView.platform = AndroidWebView();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return   WebView(
//       initialUrl: 'https://flutter.dev',
//     );
//     return Scaffold(
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: Container(
//                 child: InAppWebView(
//                   initialData: InAppWebViewInitialData(
//                     data: '',
//                     baseUrl: Uri.parse(
//                         "https://jeeliz.com/demos/jeelizWidgetGitPublicDemo/"),
//                   ),
//                   initialOptions: InAppWebViewGroupOptions(
//                       crossPlatform: InAppWebViewOptions(
//                         javaScriptEnabled: true,
//                     supportZoom: true,
//                     clearCache: true,
//                     javaScriptCanOpenWindowsAutomatically: true,
//                     mediaPlaybackRequiresUserGesture: false,
//                   )),
//                   onWebViewCreated: (InAppWebViewController controller) {},
//                   androidOnPermissionRequest:
//                       (InAppWebViewController controller, String origin,
//                           List<String> resources) async {
//                     return PermissionRequestResponse(
//                         resources: resources,
//                         action: PermissionRequestResponseAction.GRANT);
//                   },
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
