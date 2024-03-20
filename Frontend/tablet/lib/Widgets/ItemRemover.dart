import 'package:flutter/material.dart';
import 'package:tablet/Widgets/OrderWindow.dart';


class ItemRemover extends StatefulWidget{
  const ItemRemover({super.key});

  @override
  State<ItemRemover> createState() {
    return _State();
  }
}

class _State extends State<ItemRemover>{

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: blueprint.keys.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, childAspectRatio: 1.3),
        itemBuilder: (ctx, idx) {
          return Padding(
            padding: const EdgeInsets.all(30),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const BeveledRectangleBorder(),
                    padding: const EdgeInsets.all(0)),
                onPressed: () {
                    blueprint.removeWhere(
                            (key, value) => key == blueprint.keys.toList()[idx]);
                    setState(() {

                    });
                    topLeftNotifier.value = !(topLeftNotifier.value);
                },
                child: Text(blueprint.keys.toList()[idx])),
          );
        });
  }

}