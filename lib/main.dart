import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:csharp_rpc/csharp_rpc.dart';

late CsharpRpc csharpRpc;

Future<void> main() async {
  runApp(const MyApp());

  /// The path to our C# program.
  /// In release-mode we will publish the C# app to the flutter build path:
  /// "..\flutter_app\build\windows\runner\Release\csharp"
  /// so, we can use the path: "csharp/CsharpApp.exe"
  var pathToCsharpExecutableFile = true
      ? 'csharp/CsharpApp.exe'
      : "../CsharpApp/bin/Debug/net7.0-windows/CsharpApp.exe";

  /// Create and start CsharpRpc instance.
  /// you can create this instance anywhere in your program, but remember to
  /// dispose is by calling 'csharpRpc.dispose()'
  csharpRpc = await CsharpRpc(pathToCsharpExecutableFile).start();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomeScreen(),
    );
  }
}