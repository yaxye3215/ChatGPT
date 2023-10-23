import 'package:chatgbt_app/provider/models_provider.dart';
import 'package:chatgbt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';

class ModelDropDown extends StatefulWidget {
  const ModelDropDown({super.key});

  @override
  State<ModelDropDown> createState() => _ModelDropDownState();
}

class _ModelDropDownState extends State<ModelDropDown> {
  String? currentModel;

  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModel = modelProvider.getCurrentModel;
    return FutureBuilder(
      future: modelProvider.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Center(
            child: TextWidget(label: snapshot.error.toString()),
          );
        }
        if (snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        return DropdownButton(
          dropdownColor: scaffoldBackgroundColor,
          items: List<DropdownMenuItem<String>>.generate(
            snapshot.data!.length,
            (index) => DropdownMenuItem(
              value: snapshot.data![index].id,
              child: TextWidget(
                label: snapshot.data![index].id,
              ),
            ),
          ),
          value: currentModel,
          onChanged: (value) {
            setState(() {});
            modelProvider.setCurrentModel(value.toString());
          },
        );
      },
    );
  }
}
