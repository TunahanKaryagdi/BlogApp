import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../utils/string_constants.dart';
import '../../utils/tag_texts_enum.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_tag_view.dart';
import '../../widgets/custom_title.dart';

class AddView extends StatelessWidget {
  const AddView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customPageTitle(context, StringConstants.create),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingLow,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            customTitle(context, StringConstants.tags),
            context.emptySizedHeightBoxLow,
            CustomTagView(text: TagTexts.Economy.name),
            context.emptySizedHeightBoxNormal,
            customTitle(context, StringConstants.title),
            context.emptySizedHeightBoxLow,
            TextFormField(
              decoration: _inputDecoration(StringConstants.title),
            ),
            context.emptySizedHeightBoxNormal,
            customTitle(context, StringConstants.description),
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
