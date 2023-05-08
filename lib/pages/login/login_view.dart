import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../utils/custom_navigator.dart';
import '../../utils/string_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_title.dart';
import '../signup/signup_view.dart';
import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  late final LoginViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = LoginViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: context.horizontalPaddingNormal,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: SizedBox(
            height: context.height,
            child: _titlesAndInputsColumn(context),
          )),
        ),
      ),
    );
  }

  Column _titlesAndInputsColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        customPageTitle(context, StringConstants.helloText),
        context.emptySizedHeightBoxNormal,
        customTitle(context, StringConstants.email),
        TextFormField(
          controller: _viewModel.email,
          validator: _viewModel.textFieldValidator,
        ),
        context.emptySizedHeightBoxNormal,
        customTitle(context, StringConstants.password),
        TextFormField(
            controller: _viewModel.password,
            validator: _viewModel.textFieldValidator),
        context.emptySizedHeightBoxNormal,
        CustomButton(
          widget: const Text(StringConstants.login),
          onClick: () async {
            if (_formKey.currentState?.validate() ?? false) {
              await _viewModel.login(context);
            }
          },
        ),
        context.emptySizedHeightBoxNormal,
        CustomButton(
          widget: _viewModel.isLoading
              ? const CircularProgressIndicator()
              : const Text(StringConstants.signup),
          onClick: () {
            CustomNavigator.pushTo(context, const SignupView());
          },
        ),
      ],
    );
  }
}
