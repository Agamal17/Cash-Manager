import 'package:flutter/material.dart';
import 'package:tablet/Widgets/OrderWindow.dart';
import 'package:tablet/Widgets/SalesWindow.dart';

class App extends StatefulWidget{
  const App({super.key});

  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App>{
  List days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  dynamic activeWindow = const OrderWindow();
  String appBarText = 'Sales';

  void changeWindow() {
    if (activeWindow.runtimeType == OrderWindow) {
      setState(() {
        activeWindow = const SalesWindow();
        appBarText = 'Orders';
        // appbar sales text to orders text
      });
    }
    else {
      setState(() {
        activeWindow = const OrderWindow();
        appBarText = 'Sales';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    ValueNotifier<int> appBarNotifier = ValueNotifier(DateTime.now().day);
    return ValueListenableBuilder(
      valueListenable: appBarNotifier,
      builder: (ctx, bol ,wdg) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leadingWidth: 90,
          leading: TextButton(onPressed: () {} ,child: Text('${days[now.weekday-1]}\n${now.day}-${now.month}-${now.year}')),
          centerTitle: true,
          title: const Text('Cash Management System'),
          actions: [
            TextButton(onPressed: changeWindow , child: Text(appBarText))
          ],
        ),
        body: activeWindow,
      ),
    );
  }
}