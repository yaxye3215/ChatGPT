import 'package:chatgbt_app/widgets/drop_down.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/text_widget.dart';

class Service {
  static Future<void> showSnackbar({
    required BuildContext context,
  }) async {
    await showModalBottomSheet(
      backgroundColor: scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextWidget(
                  label: "ChatModel: ",
                  fontSize: 16,
                ),
              ),
              Flexible(
                flex: 2,
                child: ModelDropDown(),
              )
            ],
          ),
        );
      },
    );
  }
}
