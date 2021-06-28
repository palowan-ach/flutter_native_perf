import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/listView.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Perf',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _myName = 'Please Login';
  static const platform = const MethodChannel('ssoChannel');
  String _webViewURL =
      'https://preview.colorlib.com/theme/bootstrap/contact-form-02';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_myName),
            ElevatedButton(
              onPressed: () => _showSingleSignOn(context),
              child: Text('SSO Login'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showWebForm(context),
              child: Text('Web Form'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyListView(),
                ),
              ),
              child: Text('To List View'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showVA(context),
        child: Icon(Icons.question_answer),
      ),
    );
  }

  void _showSingleSignOn(BuildContext context) {
    final ssoPage = Scaffold(
      appBar: AppBar(title: Text('Single Sign On')),
      body: UiKitView(viewType: 'FLSingleSignOnView'),
    );
    Platform.isIOS
        ? Navigator.of(context).push(
            MaterialPageRoute(builder: (builder) => ssoPage),
          )
        : _startSSO();
  }

  void _showWebForm(BuildContext context) {
    final webPage = Scaffold(
      appBar: AppBar(title: Text('Web Form')),
      body: Platform.isIOS
          ? UiKitView(viewType: 'FLWebView')
          : AndroidView(
              viewType: 'FLWebView',
              creationParams: {'url': _webViewURL},
              creationParamsCodec: StandardMessageCodec(),
            ),
    );
    Navigator.of(context).push(
      MaterialPageRoute(builder: (builder) => webPage, fullscreenDialog: true),
    );
  }

  void _showVA(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: ClipRect(
            child: VAWebView(),
          ),
        );
      },
    );
  }

  Future<void> _startSSO() async {
    String myName;
    try {
      final String result = await platform.invokeMethod('startSSO');
      myName = result;
    } on PlatformException catch (e) {
      myName = "Failed To Login: '${e.message}'.";
    }

    setState(() {
      _myName = myName;
    });
  }
}

class VAWebView extends StatefulWidget {
  @override
  _VAWebViewState createState() => _VAWebViewState();
}

class _VAWebViewState extends State<VAWebView> {
  int _index = 1;
  late Widget _webView;

  @override
  void initState() {
    _webView = WebView(
      initialUrl: 'https://www.pinterest.com.au',
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (value) {
        setState(() {
          _index = 1;
        });
      },
      onPageFinished: (_) {
        setState(() {
          _index = 0;
        });
      },
    );
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _index,
      children: [
        _webView,
        Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
