import 'package:blog_app/utils/custom_navigator.dart';
import 'package:blog_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../utils/string_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_texts.dart';
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
        customTextField(StringConstants.name, _viewModel.name,
            Icons.account_box_outlined, _viewModel.textFieldValidator),
        context.emptySizedHeightBoxNormal,
        customTextField(StringConstants.surname, _viewModel.surname,
            Icons.account_box_outlined, _viewModel.textFieldValidator),
        context.emptySizedHeightBoxNormal,
        customTextField(StringConstants.email, _viewModel.email,
            Icons.email_outlined, _viewModel.textFieldValidator),
        context.emptySizedHeightBoxNormal,
        customTextField(StringConstants.password, _viewModel.password,
            Icons.lock_outline, _viewModel.textFieldValidator),
        context.emptySizedHeightBoxNormal,
        CustomButton(
          widget: context.watch<SignupViewModel>().isLoading
              ? const CircularProgressIndicator()
              : const Text(StringConstants.save),
          onClick: () async {
            if (_formKey.currentState?.validate() ?? false) {
              bool isSignup = await _viewModel.signUp(context);
              if (isSignup && context.mounted) {
                CustomNavigator.pushAndRemoveUntil(
                    context, StringConstants.mainRoute);
              }
            }
          },
        )
      ],
    );
  }
}
