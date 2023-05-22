import 'dart:io';

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
      _tagsRow(),
      context.emptySizedHeightBoxLow,
      customTitle(context, StringConstants.photo),
      context.emptySizedHeightBoxLow,
      _photoRow(context),
      context.emptySizedHeightBoxNormal,
      customTitle(context, StringConstants.title),
      context.emptySizedHeightBoxLow,
      _titleTextField(context),
      context.emptySizedHeightBoxNormal,
      customTitle(context, StringConstants.description),
      context.emptySizedHeightBoxLow,
      _descriptionTextField(context),
      context.emptySizedHeightBoxNormal,
      _saveButton()
    ]);
  }

  CustomButton _saveButton() {
    return CustomButton(
        widget: _viewModel.isLoading
            ? const CircularProgressIndicator()
            : const Text(StringConstants.save),
        onClick: () {
          if (_formKey.currentState?.validate() ?? false) {
            _viewModel.saveBlogToFirebase();
          }
        });
  }

  TextFormField _descriptionTextField(BuildContext context) {
    return TextFormField(
        controller: context.watch<AddViewModel>().descriptionText,
        decoration: _inputDecoration(StringConstants.description),
        minLines: 6,
        maxLines: 9,
        validator: (value) {
          if (value.isNullOrEmpty) {
            return StringConstants.typeSth;
          }
          return null;
        });
  }

  TextFormField _titleTextField(BuildContext context) {
    return TextFormField(
      controller: context.watch<AddViewModel>().titleText,
      decoration: _inputDecoration(StringConstants.title),
      validator: (value) {
        if (value.isNullOrEmpty) {
          return StringConstants.typeSth;
        }
        return null;
      },
    );
  }

  Row _photoRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: context.dynamicWidth(0.12),
            backgroundImage: context.watch<AddViewModel>().pickedImage == null
                ? null
                : Image.file(File(_viewModel.pickedImage!.path)).image),
        context.emptySizedWidthBoxLow,
        IconButton(
            onPressed: () async {
              await _viewModel.pickImageFromCamera();
            },
            icon: const Icon(Icons.add_a_photo)),
        context.emptySizedWidthBoxLow,
        IconButton(
            onPressed: () async {
              await _viewModel.pickImageFromGallery();
            },
            icon: const Icon(Icons.add_box_rounded))
      ],
    );
  }

  Row _tagsRow() {
    return Row(
      children: TagTexts.values
          .map(
            (e) => CustomSelectableTagView(
                onclick: (text, isSelected) {
                  _viewModel.checkAndUpdate(isSelected, text);
                },
                text: e.name),
          )
          .toList(),
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
