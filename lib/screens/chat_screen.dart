import 'package:chatgbt_app/constants/colors.dart';
import 'package:chatgbt_app/model/chat_model.dart';
import 'package:chatgbt_app/service/api_service.dart';
import 'package:chatgbt_app/service/assets_menager.dart';
import 'package:chatgbt_app/service/service.dart';
import 'package:chatgbt_app/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../provider/models_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isType = false;
  late TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
  }

  late FocusNode focusNode;
  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    focusNode.dispose();
  }

  List<ChatModel> chatList = [];

  Future<void> sendMessage(ModelsProvider modelProvider) async {
    try {
      setState(() {
        isType = true;
        chatList.add(
          ChatModel(
            msg: textEditingController.text,
            chatIndex: 0,
          ),
        );
      });
      chatList = await ApiService.sendMessage(
        message: textEditingController.text,
        modelId: modelProvider.getCurrentModel,
      );
      setState(() {
        isType = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.openaiLogo),
          ),
          title: const Text("ChatGPT"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Service.showSnackbar(context: context);
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ))
          ],
        ),
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: chatList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChatWidget(
                    msg: chatList[index].msg,
                    chatIndex: chatList[index].chatIndex,
                  );
                },
              ),
            ),
            if (isType) ...[
              const SpinKitThreeBounce(
                size: 16,
                color: Colors.white,
              )
            ],
            const SizedBox(
              height: 20,
            ),
            //send bottom and textfield
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      decoration: const InputDecoration.collapsed(
                        hintText: "How can I do you",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage(modelProvider);
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
