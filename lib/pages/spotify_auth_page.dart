import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class SpotifyAuthPage extends StatelessWidget {
  final Function(String code) onCodeReceived;

  SpotifyAuthPage({required this.onCodeReceived});

  @override
  Widget build(BuildContext context) {
    const String clientId = 'c78c6e9431a84790bd4affe04258d00d';
    const String redirectUri = 'http://localhost:5173/callback';
    const String scopes = 'user-read-private user-read-email';

    const String authUrl =
        'https://accounts.spotify.com/authorize?response_type=code'
        '&client_id=$clientId'
        '&redirect_uri=$redirectUri'
        '&scope=$scopes';

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {},
        onPageStarted: (authUrl) {},
        onPageFinished: (redirectUri) {},
        onNavigationRequest: (navigation) {
          final uri = Uri.parse(navigation.url);
          if (uri.toString().startsWith(redirectUri)) {
            final code = uri.queryParameters['code'];
            if (code != null) {
              onCodeReceived(code);
              Navigator.pop(context);
            }
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse('https://flutter.dev'));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Spotify Login')),
      body: WebViewWidget(controller: controller),
    );
  }
}
