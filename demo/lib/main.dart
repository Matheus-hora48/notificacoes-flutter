import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

Future<void> onBackgroundMessage(RemoteMessage message) async {
  print(message.data);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  int _counter = 0;

  @override
  void initState() {
    super.initState();

    initializeFcm();
  }

  Future<void> initializeFcm() async {
    final token = await messaging.getToken();
    print(token);

    messaging.subscribeToTopic('flamengo');

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        Flushbar(
          margin: const EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.white,
          titleColor: Colors.black,
          messageColor: Colors.black,
          title: message.notification?.title,
          message: message.notification?.body,
          duration: const Duration(seconds: 3),
          //para o tap quando ta em primeiro plano
          onTap: (_) {
            print(message.data);
            // Navigator.of(context).pushNamed(message.data['route']);
          },
        ).show(context);
      }

      print(message.data);
    });

    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    //click quando ta em background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.notification?.title);
    });

    //click quando ta em terminated
    final RemoteMessage? message = await messaging.getInitialMessage();

    if (message != null) {}
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
