// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chatgbt_app/constants/colors.dart';
import 'package:chatgbt_app/service/assets_menager.dart';
import 'package:chatgbt_app/widgets/text_widget.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key? key,
    required this.msg,
    required this.chatIndex,
  }) : super(key: key);

  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                chatIndex == 0
                    ? AssetsManager.userImage
                    : AssetsManager.botImage,
                width: 40,
                height: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextWidget(label: msg),
              ),
              const SizedBox(
                width: 5,
              ),
              chatIndex == 0
                  ? const SizedBox.shrink()
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.thumb_up_alt_outlined,
                          color: Colors.white,
                        ), // Icon
                        SizedBox(
                          width: 5,
                        ), // SizedBox
                        Icon(Icons.thumb_down_alt_outlined,
                            color: Colors.white), // Icon
                      ], // children
                    )
            ],
          ),
        ),
      ],
    );
  }
}
