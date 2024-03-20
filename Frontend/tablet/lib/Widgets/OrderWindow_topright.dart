import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tablet/Widgets/OrderWindow.dart';

class TopRight extends StatefulWidget{
  const TopRight({super.key});

  @override
  State<TopRight> createState() {
    return _State();
  }
}

class _State extends State<TopRight>{
  TextEditingController topRightNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List orderKeys = orderList.keys.toList();
    orderKeys.removeWhere((element) => element=='Sum' || element=="ID" || element=='Note');
    return SizedBox(
      height: MediaQuery.of(context).viewInsets.bottom==0.0?267:140,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(style: const TextStyle(fontSize: 18),'ID: ${orderList['ID']}'),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(3),
                child: GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 100,
                    childAspectRatio: 1.2),
                    itemCount: orderKeys.length,
                    itemBuilder: (ctx, idx) {
                      return start == false
                      ?null
                          :Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(radius: 15,child: Text('${orderList[orderKeys[orderKeys.length-1-idx]][0].toInt()}'),),
                            Center(
                              child: Text(
                                style: TextStyle(color: Colors.deepPurple.shade900),
                                  '${orderKeys[orderKeys.length-1-idx]}'
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            TextField(
              controller: topRightNoteController,
              decoration: const InputDecoration(labelText: '  Notes'),
              onTap: () {

              },
              onTapOutside: (ptr){
                  FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(style: const TextStyle(fontSize: 18),'Price:  $sum'),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                        orderList = jsonDecode(jsonEncode(blueprint));
                        orderList['Sum']=0;
                        orderList['ID']=finalID;
                        orderList['Note']='';
                        sum = 0;
                        topRightNoteController.value = const TextEditingValue(text: '');
                        setState(() {

                        });
                        start =false;
                    },
                    child: const Text("New Order")),
                ElevatedButton(
                    onPressed: () {
                        bool emptyOrder = true;
                        orderList.forEach((key, value) {
                          if (key!='Sum' && key!='ID' && key!='Note') {
                            if (value[0] != 0) emptyOrder = false;
                          }
                        });
                        if (!emptyOrder) {
                          orderList['Note']=topRightNoteController.value.text;
                          orderList['Sum']=sum;
                          waitingOrders
                              .add(jsonDecode(jsonEncode(orderList)));
                          waitingOrders[waitingOrders.length-1]['Time']=DateTime.now();
                          orderList = jsonDecode(jsonEncode(blueprint));
                          orderList['Sum']=0;
                          orderList['ID']=++finalID;
                          orderList['Note']='';
                        }
                        sum = 0;
                        topRightNoteController.value = const TextEditingValue(text: '');
                        setState(() {

                        });
                        start=false;
                        bottomRightNotifier.value = !(bottomRightNotifier.value);
                    },
                    child: const Text('Confirm'))
              ],
            )
          ],
        ),
      ),
    );
  }
}