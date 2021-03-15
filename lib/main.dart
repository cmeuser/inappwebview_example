import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

InAppLocalhostServer localhostServer = new InAppLocalhostServer();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await localhostServer.start();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'WebView Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  InAppWebViewController webView;

  final filePath = 'assets/index.html';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse('http://localhost:8080/assets/index.html')),
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
          webView.loadData(data: _loadFromString(), baseUrl: Uri.parse('http://localhost:8080/assets/'));
        },
      ),
    );
  }

  _loadFromString() {
    return '<html><head><script src="http://localhost:8080/assets/script.js"></script><link rel="stylesheet" href="http://localhost:8080/assets/styles.css"></head><body><div><img src="./image.png" alt="I\'m here but you can\'t see me!" onclick="clicked()"></div></body></html>';
  }
}
