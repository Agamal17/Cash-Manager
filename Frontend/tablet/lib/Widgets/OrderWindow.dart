import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dual_screen/dual_screen.dart';

import 'package:tablet/Widgets/OrderWindow_bottomleft.dart';
import 'package:tablet/Widgets/OrderWindow_bottomright.dart';
import 'package:tablet/Widgets/OrderWindow_topleft.dart';
import 'package:tablet/Widgets/OrderWindow_topright.dart';


// Global Variables
Map<String, List<num>> blueprint = {'Sogo2': [0,10], 'Kofta': [0,7], 'Hotdog': [0,5], 'Sausage': [0,6], 'f1':[0,3] , 'f2':[0,3], 'f3':[0,3], 'f4':[0,3]};

Map orderList = jsonDecode(jsonEncode(blueprint));
List<Map> waitingOrders = [];
List<Map> mobileOrders = [];

double sum = 0;
bool start = false;
bool search = false;
int finalID = 1;

ValueNotifier<bool> topLeftNotifier = ValueNotifier(false);
ValueNotifier<bool> topRightNotifier = ValueNotifier(false);
ValueNotifier<bool> bottomLeftNotifier = ValueNotifier(false);
ValueNotifier<bool> bottomRightNotifier = ValueNotifier(false);
TextEditingController orderIDSearchController = TextEditingController();
TextEditingController mobileIDSearchController = TextEditingController();
TextEditingController addItemNameController = TextEditingController();
TextEditingController addItemPriceController = TextEditingController();




class OrderWindow extends StatelessWidget{
  const OrderWindow({super.key});

  @override
  Widget build(BuildContext context) {
    orderList['Sum']=0;
    orderList['ID']=finalID;
    orderList['Note']='';
    return TwoPane(
      startPane: Column(
        children: [
          ValueListenableBuilder(
              valueListenable: topLeftNotifier,
              builder: (BuildContext context, bool val, Widget? child) {
                return TopLeft();
              }),
          ValueListenableBuilder(
            valueListenable: bottomLeftNotifier,
            builder: (ctx, bol, wdg) {
              return BottomLeft();
            },
          ),
        ],
      ),
      endPane: Column(
        children: [
          ValueListenableBuilder(
              valueListenable: topRightNotifier,
              builder: (ctx, bol, wdg) => TopRight()),
          const SizedBox(
            height: 3,
          ),
          ValueListenableBuilder(
              valueListenable: bottomRightNotifier,
              builder: (ctx, bol, wdg) => BottomRight()),
        ],
      ),
    );
  }
}
