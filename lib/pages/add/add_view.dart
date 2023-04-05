import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../utils/string_constants.dart';
import '../../utils/tag_texts_enum.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_tag_view.dart';

class AddView extends StatelessWidget {
  const AddView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstants.create,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .merge(TextStyle(color: Theme.of(context).primaryColor)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingLow,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              StringConstants.tags,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            context.emptySizedHeightBoxLow,
            CustomTagView(text: TagTexts.Economy.name),
            context.emptySizedHeightBoxNormal,
            Text(
              StringConstants.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            context.emptySizedHeightBoxLow,
            TextFormField(
              decoration: _inputDecoration(StringConstants.title),
            ),
            context.emptySizedHeightBoxNormal,
            Text(
              StringConstants.description,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            context.emptySizedHeightBoxLow,
            TextFormField(
              decoration: _inputDecoration(StringConstants.description),
              minLines: 6,
              maxLines: 9,
            ),
            context.emptySizedHeightBoxNormal,
            CustomButton(text: StringConstants.save, onClick: () {})
          ]),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        fillColor: const Color.fromARGB(255, 231, 230, 230),
        filled: true);
  }
}
