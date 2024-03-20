import 'package:flutter/material.dart';

class SalesWindow extends StatefulWidget{
  const SalesWindow({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SalesWindowState();
  }
}

class _SalesWindowState extends State<SalesWindow>{

  @override
  Widget build(BuildContext context) {
    return const Text('Sales History');
  }
}