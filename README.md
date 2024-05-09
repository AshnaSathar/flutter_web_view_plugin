# Web view using flutter_webview_plugin
#step 1:

create a file network_security_config.xml inside android>app>src>main>xml with contents:

      <?xml version="1.0" encoding="utf-8"?>
      <network-security-config>
          <domain-config cleartextTrafficPermitted="true">
              <domain includeSubdomains="true">"YOUR URL"</domain>
          </domain-config>
      </network-security-config>
	
step 2:

create a file named provider_paths.xml inside android>app>src>main>xml with contents:

      <?xml version="1.0" encoding="utf-8"?>
      <paths xmlns:android="http://schemas.android.com/apk/res/android">
        <root-path name="root" path="." />
        <external-path name="external" path="." />
        <external-files-path name="external_files" path="." />
        <cache-path name="cache" path="." />
        <external-cache-path name="external_cache" path="." />
        <files-path name="files" path="." />
      </paths>
	
step 3: edit android>app>src>main>AndroidManifest.xml

with <manifestxmls:...>tag add <manifestxmls:...xmlns:tools="http://schemas.android.com/tools">
      also you can add permissions you need in your application
	
        <uses-permission android:name="android.permission.CAMERA"/>
        <uses-permission android:name="android.permission.INTERNET"/>
        <uses-permission android:name="android.permission.RECORD_AUDIO" />
        <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
        <uses-permission android:name="android.permission.VIDEO_CAPTURE" />
        <uses-permission android:name="android.permission.AUDIO_CAPTURE" />
	  
 also, inside <application tag add
	
        android:usesCleartextTraffic="true"
        android:networkSecurityConfig="@xml/network_security_config"
	  
        <provider
            android:name="androidx.core.content.FileProvider"
            android:authorities="${applicationId}.fileprovider"
            android:exported="false"
            android:grantUriPermissions="true"
            tools:replace="android:authorities">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/provider_paths"
                tools:replace="android:resource" />
        </provider> 
	  
step 4: editing main()

add   
	
          WidgetsFlutterBinding.ensureInitialized();
	    
add permissions if you want
	
          await Permission.bluetooth.request();
          await Permission.audio.request();
          await Permission.camera.request();
          await Permission.microphone.request();
	    
Define plugin for fetching device id
	
          var deviceInfo = DeviceInfoPlugin();
 Define plugin to integrate webview.
	
          final FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();
	    
step 5:inside webviewScaffold()- This channel allows communication between JavaScript running inside the webview and Dart code in your 
       Flutter app.
	 
       javascriptChannels: {
              JavascriptChannel(
                  name: "sample",
                 ## When a message is received on this channel from JavaScript, the onMessageReceived function is triggered.
                  onMessageReceived: (JavascriptMessage message) {
                    print(message.message);
                    getData();
                  })
            }),
		
step 6: flutterWebviewPlugin.evalJavascript('setdeviceId(`$deviceId`)'); this is the code responsible for executing JavaScript code inside a 
WebView in your Flutter app.

        void sendDataToJavaScript() {
            flutterWebviewPlugin.evalJavascript('setdeviceId(`$deviceId`)');
          }  
 inside javascript: 
 
            function setdeviceId(deviceId){
              document.getElementById('deviceid').value=deviceId;
            }
            function connectFlutter() {
                try {
                    sample.onmessage = function(event) {
                     var dataFromFlutter = event.data;
                    };
                      } catch (error) {
                          console.log("error",error)   
                      }
                  }
