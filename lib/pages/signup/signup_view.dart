import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../utils/string_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_title.dart';
import 'signup_view_model.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  late final SignupViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SignupViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: _viewModel,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: context.horizontalPaddingNormal,
              child: Form(
                key: _formKey,
                child: SizedBox(
                  height: context.height,
                  child: _titleAndInputColumn(context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Column _titleAndInputColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customPageTitle(context, StringConstants.signup),
        context.emptySizedHeightBoxNormal,
        customTitle(context, StringConstants.name),
        TextFormField(
          controller: _viewModel.name,
          validator: _viewModel.textFieldValidator,
        ),
        context.emptySizedHeightBoxNormal,
        customTitle(context, StringConstants.surname),
        TextFormField(
          controller: _viewModel.surname,
          validator: _viewModel.textFieldValidator,
        ),
        context.emptySizedHeightBoxNormal,
        customTitle(context, StringConstants.email),
        TextFormField(
            controller: _viewModel.email,
            validator: _viewModel.textFieldValidator),
        context.emptySizedHeightBoxNormal,
        customTitle(context, StringConstants.password),
        TextFormField(
            controller: _viewModel.password,
            validator: _viewModel.textFieldValidator),
        context.emptySizedHeightBoxNormal,
        CustomButton(
          widget: const Text(StringConstants.save),
          onClick: () async {
            if (_formKey.currentState?.validate() ?? false) {
              await _viewModel.signUp();
            }
          },
        )
      ],
    );
  }
}
