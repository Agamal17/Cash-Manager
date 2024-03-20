import 'package:flutter/material.dart';
import 'package:tablet/Widgets/OrderWindow.dart';

class BottomRight extends StatelessWidget{
  const BottomRight({super.key});

  List orderKeys(Map x){
    var y = x.keys.toList();
    y.removeWhere((element) => element=='Sum' || element=="ID" || element=='Note' || element=='Time');
    return y;
  }

  List orderValues(Map x){
    Map y = Map.of(x);
    y.removeWhere((key, value) => key=='Sum' || key=='ID' || key=='Note' || key=='Time');
    return y.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    List searched = [];

    search == true ? searched = waitingOrders.where((element) => element['ID'].toString().contains(orderIDSearchController.value.text)).toList() : null;
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 100,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: orderIDSearchController,
                  decoration: const InputDecoration(labelText: 'Search by ID:'),
                  onTap: (){

                  },
                  onTapOutside: (ptr){
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onChanged: (txt) {
                    if (txt.isNotEmpty) {
                      search = true;
                      bottomRightNotifier.value = !(bottomRightNotifier.value);
                    }
                    else if (txt.isEmpty){
                      search = false ;
                      bottomRightNotifier.value = !(bottomRightNotifier.value);
                    }
                  },),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent, ),
                onPressed: () {},
                child: Text(
                  'Waiting List: ${waitingOrders.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 20,)
            ],
          ),
          Expanded(
            child: search == true
                  ?ListView(
              children:[
                if (searched.isNotEmpty)
                ...searched.map((e) => ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: Dismissible(
                    key: Key(e['ID'].toString()),
                    onDismissed: (direction) {
                      waitingOrders.removeWhere((element) => element['ID']==e['ID']);
                      bottomRightNotifier.value = !bottomRightNotifier.value;
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 255,255,255),
                      elevation: 5,
                      // shadowColor: Colors.lightBlueAccent.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(style: const TextStyle(fontWeight: FontWeight.bold),'ID: ${e['ID']}'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(style: const TextStyle(fontWeight: FontWeight.bold), "Price: ${e['Sum']}"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(style: const TextStyle(fontWeight: FontWeight.bold), "Time: ${e['Time'].hour}:${e['Time'].minute}"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold), "Note: ${e['Note']}")
                                ],
                              ),
                            ),
                            // const Spacer(),
                            Flexible(
                              flex: 2,
                              child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: e.keys.length - 4,
                                gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 100,),
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(radius: 15, child: Text('${orderValues(e)[(e.keys.length-5)-index][0]}')),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                                style: TextStyle(color: Colors.deepPurple.shade900, fontSize: 16),
                                                '${orderKeys(e)[(e.keys.length-5)-index]}'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
              else TextButton(onPressed: () {}, child: const Text('No Entries Found'))
          ]
              ,
            )
                  :ListView.builder(
                itemCount: waitingOrders.length,
                itemBuilder: (ctx, idx) {
                  return ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: Dismissible(
                      onDismissed: (direction) {
                        waitingOrders.removeAt(waitingOrders.length-1-idx);
                        bottomRightNotifier.value = !bottomRightNotifier.value;
                      },
                      key: Key(waitingOrders[waitingOrders.length-1-idx]['ID'].toString()),
                      child: Card(
                        color: const Color.fromARGB(255, 255,255,255),
                        elevation: 5,
                        // shadowColor: Colors.lightBlueAccent.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(style: const TextStyle(fontWeight: FontWeight.bold),'ID: ${waitingOrders[waitingOrders.length-1-idx]['ID']}'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(style: const TextStyle(fontWeight: FontWeight.bold), "Price: ${waitingOrders[waitingOrders.length-1-idx]['Sum']}"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(style: const TextStyle(fontWeight: FontWeight.bold), "Time: ${waitingOrders[waitingOrders.length-1-idx]['Time'].hour}:${waitingOrders[waitingOrders.length-1-idx]['Time'].minute}"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold), "Note: ${waitingOrders[waitingOrders.length-1-idx]['Note']}")
                                  ],
                                ),
                              ),
                              // const Spacer(),
                              Flexible(
                                flex: 2,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: waitingOrders[waitingOrders.length-1-idx].keys.length - 4,
                                  gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 100,),
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(radius: 15, child: Text('${orderValues(waitingOrders[waitingOrders.length-1-idx])[waitingOrders[waitingOrders.length-1-idx].keys.length - 5-index][0]}')),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                  style: TextStyle(color: Colors.deepPurple.shade900, fontSize: 16),
                                                  '${orderKeys(waitingOrders[waitingOrders.length-1-idx])[waitingOrders[waitingOrders.length-1-idx].keys.length - 5-index]}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
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