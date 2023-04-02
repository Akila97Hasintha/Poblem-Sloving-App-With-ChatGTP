import 'package:chat_gtp_app/models/models_model.dart';
import 'package:chat_gtp_app/provider/modelProvider.dart';
import 'package:chat_gtp_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:chat_gtp_app/constraints/constant.dart';
import '../constraints/constant.dart';
 class ModelDrop extends StatefulWidget {
   const ModelDrop({Key? key}) : super(key: key);

   @override
   State<ModelDrop> createState() => _ModelDropState();
 }

 class _ModelDropState extends State<ModelDrop> {
   String? currentModel;
   @override
   Widget build(BuildContext context) {
     final modelsProvider = Provider.of<ModelsProvider>(context,listen:false);
     currentModel = modelsProvider.getCurrentModel;
     return FutureBuilder<List<ModelsModel>>(
       future: modelsProvider.getAllModels() ,
         builder: (context , snapshot){
         if(snapshot.hasError) {
           return Center(
             child:Text(snapshot.error.toString()),
           );
         }
         return snapshot.data == null || snapshot.data!.isEmpty
             ? const SizedBox.shrink()
             : DropdownButton(
             dropdownColor: Colors.grey ,
             iconEnabledColor: Colors.white,
             items:  List<DropdownMenuItem<String>>.generate(
                 snapshot.data!.length,
                     (index) => DropdownMenuItem(
                     value: snapshot.data![index].id,
                     child:Text(snapshot.data![index].id,style: const TextStyle(fontSize: 15),) )),
             value:currentModel,
             onChanged: (value){
               setState(() {
                 currentModel =value.toString();
               });
               modelsProvider.setCurrentModel(value.toString());
             });
         }
     );
   }
 }

 /* DropdownButton(
       dropdownColor: Colors.grey ,
         iconEnabledColor: Colors.white,
         items:  getModelsItem,
         value:currentModel,
         onChanged: (value){
            setState(() {
              currentModel =value.toString();
            });
         });   */
