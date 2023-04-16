import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../utils/string_constants.dart';
import '../../utils/tag_texts_enum.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_selectable_tag_view.dart';
import '../../widgets/custom_title.dart';
import 'add_view_model.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  late final AddViewModel _viewModel;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _viewModel = AddViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: customPageTitle(context, StringConstants.create),
        ),
        body: ChangeNotifierProvider.value(
          value: _viewModel,
          builder: (context, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: context.paddingLow,
                child: Form(
                  key: _formKey,
                  child: _titlesAndInputColumn(context),
                ),
              ),
            );
          },
        ));
  }

  Column _titlesAndInputColumn(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      customTitle(context, StringConstants.tags),
      context.emptySizedHeightBoxLow,
      Row(
        children: TagTexts.values
            .map(
              (e) => CustomSelectableTagView(
                  onclick: (text, isSelected) {
                    _viewModel.checkAndUpdate(isSelected, text);
                  },
                  text: e.name),
            )
            .toList(),
      ),
      context.emptySizedHeightBoxNormal,
      customTitle(context, StringConstants.title),
      context.emptySizedHeightBoxLow,
      TextFormField(
        controller: context.watch<AddViewModel>().titleText,
        decoration: _inputDecoration(StringConstants.title),
        validator: (value) {
          if (value.isNullOrEmpty) {
            return StringConstants.typeSth;
          }
          return null;
        },
      ),
      context.emptySizedHeightBoxNormal,
      customTitle(context, StringConstants.description),
      context.emptySizedHeightBoxLow,
      TextFormField(
          controller: context.watch<AddViewModel>().descriptionText,
          decoration: _inputDecoration(StringConstants.description),
          minLines: 6,
          maxLines: 9,
          validator: (value) {
            if (value.isNullOrEmpty) {
              return StringConstants.typeSth;
            }
            return null;
          }),
      context.emptySizedHeightBoxNormal,
      CustomButton(
          widget: const Text(StringConstants.save),
          onClick: () {
            if (_formKey.currentState?.validate() ?? false) {
              _viewModel.saveBlogToFirebase();
            }
          })
    ]);
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        fillColor: const Color.fromARGB(255, 231, 230, 230),
        filled: true);
  }
}
