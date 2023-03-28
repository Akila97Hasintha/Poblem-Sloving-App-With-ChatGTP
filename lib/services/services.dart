
import 'package:flutter/material.dart';
import '../widgets/drop_down.dart';
import '../constraints/constant.dart';

class Services{
  static Future<void> showModelSheet({required BuildContext context}) async{
    await showModalBottomSheet(
        backgroundColor: Colors.grey,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(20)
          ),
        ),
        //
        context: context, builder: (context){
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
          Flexible(child: Text("choosen model")),
          Flexible(
            flex: 2,
              child: ModelDrop()),
        ],),
      );
    });
  }
}