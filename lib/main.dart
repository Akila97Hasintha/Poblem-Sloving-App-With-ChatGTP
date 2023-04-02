import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constraints/constant.dart';
import 'Screens/chatScreen.dart';
import 'package:device_preview/device_preview.dart';
import 'provider/modelProvider.dart';
void main() {
  runApp(
    DevicePreview(

      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ModelsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         scaffoldBackgroundColor: scaffoldBackgroundColor,
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            color: cardColor,
          )
        ),
        home: const ChatScreen(),
      ),
    );
  }
}

