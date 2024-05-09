import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.bluetooth.request();
  await Permission.audio.request();
  await Permission.camera.request();
  await Permission.microphone.request();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var deviceInfo = DeviceInfoPlugin();
  final FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    getData();
    super.initState();
  }

  String? deviceId;
  getData() async {
    deviceId = await _getId();
    if (deviceId != null) {
      try {
        sendDataToJavaScript();
      } catch (e) {
        print("error is $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('WebView Example'),
        ),
        body: WebviewScaffold(
            allowFileURLs: true,
            geolocationEnabled: true,
            mediaPlaybackRequiresUserGesture: true,
            withJavascript: true,
            withLocalUrl: true,
            url: 'http://192.168.1.35',
            javascriptChannels: {
              JavascriptChannel(
                  name: "sample",
                  onMessageReceived: (JavascriptMessage message) {
                    print(message.message);
                    getData();
                  })
            }),
      ),
    );
  }

  Future _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    } else if (Platform.isMacOS) {
      var macInfo = await deviceInfo.macOsInfo;
      print('Model: ${macInfo.model}');
      return '${macInfo.systemGUID}';
    }
  }

  void sendDataToJavaScript() {
    flutterWebviewPlugin.evalJavascript('setdeviceId(`$deviceId`)');
  }
}
