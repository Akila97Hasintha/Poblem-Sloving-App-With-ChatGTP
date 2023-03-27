import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:chat_gtp_app/constraints/constant.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final bool _isTyping =true;

  late TextEditingController textEditingController;
  @override
  void initState(){
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/openai_logo.jpg'),
        ),title: const Text('ChatGtp'),
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_rounded,color:Colors.white))],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: 6,
                  itemBuilder: (context,index) {
                    return const Text("hello this is text!!");
                  }),
            ),
            if(_isTyping)...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(height: 20,),
              Material(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: textEditingController,
                        onSubmitted: (value){

                        },
                        decoration: const InputDecoration.collapsed(
                            hintText: "How Can I help You..?",
                            hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.send,color:Colors.white))
                    ],
                  ),
                ),
              ),
            ]
          ],
        ),
      )
    );
  }
}