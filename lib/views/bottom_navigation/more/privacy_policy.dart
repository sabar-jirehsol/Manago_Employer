import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late WebViewController _controller;
  bool _isLoading = true; // Initial loading state

  @override
  void initState() {
    super.initState();
    // Enable Hybrid Composition for Android WebView (if needed)
    if (WebView.platform is AndroidWebView) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Privacy Policy'),
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl: 'https://manago.in/policies.html',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
              },
              onPageStarted: (String url) {
                setState(() {
                  _isLoading = true;
                });
              },
              onPageFinished: (String url) {
                setState(() {
                  _isLoading = false;
                });
              },
              onWebResourceError: (WebResourceError error) {
                setState(() {
                  _isLoading = false;
                });
                print('Error loading page: $error');
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('whatsapp://')) {
                  // Handle WhatsApp link directly
                  print('Opening WhatsApp link: ${request.url}');
                  // Handle how to open WhatsApp link here
                  // For example, launch WhatsApp using url_launcher package
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
