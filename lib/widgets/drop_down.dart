import 'package:flutter/material.dart';
//import 'package:chat_gtp_app/constraints/constant.dart';
import '../constraints/constant.dart';
 class ModelDrop extends StatefulWidget {
   const ModelDrop({Key? key}) : super(key: key);

   @override
   State<ModelDrop> createState() => _ModelDropState();
 }

 class _ModelDropState extends State<ModelDrop> {
   String currentModel = "Model1";
   @override
   Widget build(BuildContext context) {
     return DropdownButton(
       dropdownColor: Colors.grey ,
         iconEnabledColor: Colors.white,
         items:  getModelsItem,
         value:currentModel,
         onChanged: (value){
            setState(() {
              currentModel =value.toString();
            });
         });
   }
 }
