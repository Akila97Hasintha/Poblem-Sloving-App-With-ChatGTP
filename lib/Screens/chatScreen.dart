
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:chat_gtp_app/constraints/constant.dart';
import 'package:chat_gtp_app/widgets/Chat_widget.dart';
import 'package:chat_gtp_app/services/services.dart';
import 'package:chat_gtp_app/services/api_services.dart';
import 'package:provider/provider.dart';

import '../models/chat_model.dart';
import '../provider/modelProvider.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
   bool _isTyping =true;
   late ScrollController _listScrollContraller;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  @override
  void initState(){
    _listScrollContraller = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollContraller.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }
  List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/openai_logo.jpg'),
          ),title: const Text('ChatGtp'),
          actions: [IconButton(onPressed:  () async {

                await Services.showModelSheet(context: context);
          }, icon: const Icon(Icons.more_vert_rounded,color:Colors.white))],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  controller: _listScrollContraller,
                  itemCount: chatList.length,
                    itemBuilder: (context,index) {
                      return  ChatWidget(
                        msg: chatList[index].msg,
                        chatIndex: chatList[index].chatIndex,
                      );
                    }),
              ),
              if(_isTyping)...[
                const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 18,
                ),],
                const SizedBox(height: 20,),
                Material(
                  color: cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                              focusNode: focusNode,
                          style: const TextStyle(color: Colors.white),
                          controller: textEditingController,
                          onSubmitted: (value)async {
                            await sendMessage(modelsProvider: modelsProvider,textEditingController:textEditingController,);
                          },
                          decoration: const InputDecoration.collapsed(
                              hintText: "How Can I help You..?",
                              hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        IconButton(onPressed: () async {
                          //print(textEditingController.text);
                                await sendMessage(modelsProvider: modelsProvider,textEditingController:textEditingController,);
                        }, icon: const Icon(Icons.send,color:Colors.white))
                      ],
                    ),
                  ),
                ),

            ],
          ),
        )
      ),
    );
  }
  
  void scrolListEnd(){
    _listScrollContraller.animateTo(
        _listScrollContraller.position.maxScrollExtent,
        duration: const Duration(seconds: 5)
        , curve: Curves.easeOut
    );
  }
  Future<void> sendMessage({required ModelsProvider modelsProvider,required TextEditingController textEditingController}) async {
    String model = "gpt-3.5-turbo-0301";
    try{
      setState(() {
        _isTyping = true;
        chatList.add(ChatModel(textEditingController.text, 0));
        //textEditingController.clear();
        focusNode.unfocus();
      });
      print("hi :${textEditingController.text}");
      chatList.addAll(await ApiService.sendMsg(message: textEditingController.text,modelId: model));
      setState(() {
        textEditingController.clear();
      });
    }catch(error){
      // log("errror$error");
      print(error);
    }finally{
      setState(() {
        scrolListEnd();
        _isTyping = false;
      });
    }
  }
}
