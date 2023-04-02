class ChatModel{
  late final String msg;
   final int chatIndex;

  ChatModel(this.msg, this.chatIndex);

  factory ChatModel.fromJson(Map<String,dynamic> json) => ChatModel(
      json["msg"],int.parse(json["chatIndex"]) );
}