// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: Container(
//                 child: InAppWebView(
//                   initialData:
//                   "https://jeeliz.com/demos/jeelizWidgetGitPublicDemo/",
//                   initialOptions: InAppWebViewGroupOptions(
//                       crossPlatform: InAppWebViewOptions(
//                         mediaPlaybackRequiresUserGesture: false,
//                         debuggingEnabled: true,
//                       )),
//                   onWebViewCreated: (InAppWebViewController controller) {
//                     _inAppWebViewController = controller;
//                   },
//                   androidOnPermissionRequest:
//                       (InAppWebViewController controller, String origin,
//                       List<String> resources) async {
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
