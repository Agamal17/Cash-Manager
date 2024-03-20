import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tablet/Widgets/OrderWindow.dart';

class BottomLeft extends StatelessWidget{
  const BottomLeft({super.key});

  List orderKeys(Map x){
    var y = x.keys.toList();
    y.removeWhere((element) => element=='Sum' || element=="ID" || element=='Note');
    return y;
  }

  List orderValues(Map x){
    Map y = jsonDecode(jsonEncode(x));
    y.removeWhere((key, value) => key=='Sum' || key=='ID' || key=='Note');
    return y.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    List searched = [];
    search == true ? searched = mobileOrders.where((element) => element['ID'].toString()==mobileIDSearchController.value.text).toList() : null;
    return Expanded(
      child: Column(
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 100,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: mobileIDSearchController,
              decoration: const InputDecoration(labelText: 'Search by ID:'),
              onTap: () {

              },
              onTapOutside: (ptr){
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: (txt) {
                if (txt.isNotEmpty) {
                  search = true;
                  bottomLeftNotifier.value = !(bottomLeftNotifier.value);
                }
                else if (txt.isEmpty){
                  search = false ;
                  bottomLeftNotifier.value = !(bottomLeftNotifier.value);
                }
              },),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent, ),
            onPressed: () {},
            child: Text(
              'Mobile Orders: ${mobileOrders.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 50,)
        ],
      ),
          Expanded(
            child: search == true
                ?ListView(
              children: [
                searched.isNotEmpty
                    ?Card(
                  color: Colors.lightBlueAccent.shade100,
                  elevation: 8,
                  shadowColor: Colors.deepPurpleAccent,
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('ID: ${searched[0]['ID']}'),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("Price: ${searched[0]['Sum']}"),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("Time: "),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Flexible(
                            flex: 2,
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: searched[0].keys.length - 3,
                              gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 100,
                                  childAspectRatio: 2),
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Center(
                                    child: Text(
                                        style: TextStyle(color: Colors.deepPurple.shade900, fontSize: 16),
                                        '${orderValues(searched[0])[index][0]}  ${orderKeys(searched[0])[index]} '),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    :TextButton(onPressed: () {}, child: const Text('No Entries Found'))
              ],
            )
                :ListView.builder(
                itemCount: mobileOrders.length,
                itemBuilder: (ctx, idx) {
                  return Card(
                    color: Colors.lightBlueAccent.shade100,
                    elevation: 8,
                    shadowColor: Colors.deepPurpleAccent,
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [Text('ID: ${mobileOrders[mobileOrders.length-1-idx]['ID']}'),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("Price: ${mobileOrders[mobileOrders.length-1-idx]['Sum']}"),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("Uptime: "),
                                const SizedBox(
                                  height: 10,
                                ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Flexible(
                              flex: 2,
                              child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: mobileOrders[mobileOrders.length-1-idx].keys.length - 3,
                                gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 100,
                                    childAspectRatio: 2),
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Center(
                                      child: Text(
                                          style: TextStyle(color: Colors.deepPurple.shade900, fontSize: 16),
                                          '${mobileOrders[mobileOrders.length-1-idx].values.toList()[index][0]}  ${mobileOrders[mobileOrders.length-1-idx].keys.toList()[index]} '),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}