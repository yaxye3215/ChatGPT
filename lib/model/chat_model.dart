// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatModel {
  final String msg;
  final int chatIndex;
  ChatModel({
    required this.msg,
    required this.chatIndex,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        msg: json["chat"],
        chatIndex: json["chatIndex"],
      );
}
