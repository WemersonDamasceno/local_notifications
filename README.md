# Notificações Push com Imagem no Flutter

Este documento fornece instruções para configurar notificações push utilizando Firebase Cloud Messaging (FCM) com imagens no Flutter. Todas as partes essenciais do código estão incluídas para facilitar a implementação.

---


## 0. Após implementação


https://github.com/user-attachments/assets/5046027e-75fa-48b3-b53c-c924e677b7cb



---

## 1. Dependências Necessárias

Adicione as seguintes dependências ao arquivo `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  firebase_core: ^3.12.1
  firebase_messaging: ^15.2.4
  flutter_local_notifications: ^18.0.1
  path_provider: ^2.1.5
  http: ^1.3.0
```

Rodar o comando:
```sh
flutter pub get
```

---

## 2. Configuração do Android

### 2.1. Permissões no `AndroidManifest.xml`
Adicione as permissões abaixo:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
    <uses-permission android:name="android.permission.VIBRATE"/>
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>

    <application
        android:label="notifications_firebase"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">

        <activity>
            .
            .
            .
        </activity>

        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />

        <!-- Altera o icone da notificacao padrão do FCM -->
        <meta-data
            android:name="com.google.firebase.messaging.default_notification_icon"
            android:resource="@mipmap/ic_notification" />

    </application>
</manifest>
```

---

## 3. Configuração do iOS

No arquivo `Info.plist`, adicione:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<!-- For Notifications -->
<key>UIBackgroundModes</key>
	<array>
		<string>fetch</string>
		<string>remote-notification</string>
	</array>
	<key>FirebaseAppDelegateProxyEnabled</key>
	<false/>
	<key>UIUserNotificationSettings</key>
	<dict>
		<key>UIUserNotificationAlert</key>
		<true/>
		<key>UIUserNotificationSound</key>
		<true/>
		<key>UIUserNotificationBadge</key>
		<true/>
	</dict>

	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
	<!-- For Notifications -->
    .
    .
    .
</dict>
</plist>
```

No arquivo `AppDelegate.swift`, inclua:

```swift
import Flutter
import UIKit
import flutter_local_notifications // Add this import for local notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }

    GeneratedPluginRegistrant.register(with: self)
    
    // To show notifications
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

---

## 4. Implementação do Serviço de Notificação

Crie um arquivo `notification_service.dart`:

```dart
class NotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
  /// Stream para verificarmos na view, que poderia ser um keyNavigation global em um arquivo de routes
  final _notificationStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get onNotificationTap =>
      _notificationStreamController.stream;
  
  /// Faz o setup do local_notifications e do FCM.
  Future<void> initialize() async {
    await PermissionService.requestPermissions();
    await _initializeLocalNotifications();
    await _getDeviceFcmToken();

    /// Metodos que escutam os eventos
    _setupForegroundMessageHandler();
    _setupBackgroundMessageHandler();
    _setupTerminatedMessageHandler();
  }
  
  /// Faz o setup inicial do flutter_local_notifications
  Future<void> _initializeLocalNotifications() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_notification'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );

    await _localNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          _notificationStreamController.add(json.decode(response.payload!));
        }
      },
    );
  }
  
  /// Busca o token do FCM para que a notificação seja exclusiva.
  Future<void> _getDeviceFcmToken() async {
    String? token = await _firebaseMessaging.getToken();
    print("Token do dispositivo: $token");
  }

  /// Notificação com o app aberto.
  void _setupForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        _showNotification(message);
      }
    });
  }
  
  /// Notificação com o app em segundo plano.
  void _setupBackgroundMessageHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _notificationStreamController.add(message.data);
    });
  }

  /// Notificação com o app fechado.
  Future<void> _setupTerminatedMessageHandler() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null && initialMessage.data.isNotEmpty) {
      _notificationStreamController.add(initialMessage.data);
    }
  }

  /// Notificação do app
  Future<void> _showNotification(RemoteMessage message) async {
    final styleInformation = await _getImageNotification(
        imageUrl: message.notification?.android?.imageUrl);

    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'fcm_notification_channel',
        'Fcm Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
        category: AndroidNotificationCategory.message,
        icon: '@mipmap/ic_notification',
        largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        styleInformation: styleInformation,
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _localNotificationsPlugin.show(
      message.ttl ?? 0,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  /// Baixa a imagem e converte para exibir na notificacao (caso exista).
  Future<BigPictureStyleInformation?> _getImageNotification({
    required String? imageUrl,
  }) async {
    if (imageUrl == null) {
      return null;
    }

    String? filePath = await PathService.downloadAndSaveFile(
      imageUrl,
      'image.jpg',
    );

    return BigPictureStyleInformation(
      filePath != null
          ? FilePathAndroidBitmap(filePath)
          : const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
  }
}

```

---

## 5. Serviço para Download de Imagens

Crie um arquivo `path_service.dart`:

```dart
/// Implementação do serviço de manipulação de arquivos
class PathService {
  static Future<String?> downloadAndSaveFile(
      String url, String fileName) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Directory tempDir = await getTemporaryDirectory();
        final File file = File('${tempDir.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        return file.path;
      }
    } catch (e) {
      print('Erro ao baixar a imagem: $e');
    }
    return null;
  }
}

```

---

## 6. Configuração no `main.dart`

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// Inicializa o Firebase
  await Firebase.initializeApp();

  /// Inicializa as configurações para o PushNotification
  await NotificationService().initialize();

  runApp(const MyApp());
}
```
