import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as path;

Future<bool> createFileZipFile(
    String src,
    String? password,
    ) async {
  try {
    final encoder = ZipFileEncoder(password: "pippo");
    encoder.create(path.setExtension(src, ".zip"));
    await encoder.addFile(File(src), path.basename(src), ZipFileEncoder.STORE);
    encoder.close();
    //await File(src).delete();
    return true;
  } catch (e) {
    print("Cannot create zip file $e");
    return false;
  }
}

bool createZipFile(
  String path,
  String name,
  List<int> bytes,
  String? password,
) {
  try {
    final encoder = ZipFileEncoder(password: password);
    encoder.create(path);
    encoder.addArchiveFile(ArchiveFile(name, 0, bytes));
    encoder.close();
    return true;
  } catch (e) {
    print("Cannot create zip file $e");
    return false;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final now = DateTime.now();
  //await File("c:\\x\\v.mp4").delete();
  //Uint8List bytes = await File("c:\\x\\v.mp4").readAsBytes();
  createFileZipFile("c:\\x\\v.mp4", "pippo");
  print("Time ${DateTime.now().difference(now).inSeconds}");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
