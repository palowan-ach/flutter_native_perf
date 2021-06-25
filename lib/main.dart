import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showSingleSignOn(context),
              child: Text('SSO Login'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showWebForm(context),
              child: Text('Web Form'),
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
    Navigator.of(context).push(
      MaterialPageRoute(builder: (builder) => ssoPage),
    );
  }

  void _showWebForm(BuildContext context) {
    final webPage = Scaffold(
      appBar: AppBar(title: Text('Web Form')),
      body: UiKitView(viewType: 'FLWebView'),
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
