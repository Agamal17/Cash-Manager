
import 'package:flutter/material.dart';
import 'package:tablet/Widgets/ItemRemover.dart';
import 'package:tablet/Widgets/OrderWindow.dart';

class TopLeft extends StatelessWidget{
  const TopLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom==0.0?193:0,
          child: GridView.builder(
              itemCount: blueprint.keys.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6),
              itemBuilder: (ctx, idx) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.all(Radius.circular(20))),
                          padding: const EdgeInsets.all(0)),
                      onPressed: () {
                        start=true;
                        (orderList[blueprint.keys.toList()[idx]])==null
                        ? orderList[blueprint.keys.toList()[idx]]=[1,blueprint.values.toList()[idx][1]]
                        : orderList[blueprint.keys.toList()[idx]][0]++;
                        orderList
                            .removeWhere((key, value) => key!='Sum' && key!='ID' && key!='Note' && value[0] == 0);

                        sum = 0;
                        orderList.forEach((key, value) {
                          if (key!='Sum' && key!='ID' && key!='Note') {
                            sum += value[0] * value[1];
                          }
                        });
                        topRightNotifier.value = !(topRightNotifier.value);
                      },
                      child: Text(blueprint.keys.toList()[idx])),
                );
              }),
        ),
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom==0.0?20:0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MediaQuery.of(context).viewInsets.bottom==0.0?ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const ItemRemover();
                    },
                  );
                },
                child: const Text("Remove Item")):const SizedBox(height: 0,),
            MediaQuery.of(context).viewInsets.bottom==0.0?ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(context: context,isScrollControlled: true,useSafeArea: true, builder: (ctx) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(16,16,16,MediaQuery.of(ctx).viewInsets.bottom+16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              controller: addItemNameController,
                              decoration: const InputDecoration(labelText: 'Item Name'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: addItemPriceController,
                              decoration: const InputDecoration(labelText: 'Item Price'),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(onPressed: () {
                                  Navigator.pop(ctx);
                                  addItemNameController.value = const TextEditingValue(text: '');
                                  addItemPriceController.value = const TextEditingValue(text: '');
                                }, child: const Text('Cancel')),
                                ElevatedButton(onPressed: () {
                                  blueprint[addItemNameController.value.text]=[0,double.tryParse(addItemPriceController.value.text)!];
                                  topLeftNotifier.value = !(topLeftNotifier.value);
                                  Navigator.pop(ctx);
                                  addItemNameController.value = const TextEditingValue(text: '');
                                  addItemPriceController.value = const TextEditingValue(text: '');
                                }, child: const Text('Add'))
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
                }, child: const Text("Add new Item")):const SizedBox(height: 0,),
            const SizedBox(
              width: 30,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
