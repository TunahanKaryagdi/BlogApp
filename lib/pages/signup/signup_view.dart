import 'package:blog_app/utils/custom_navigator.dart';
import 'package:blog_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../utils/strings.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_texts.dart';
import 'signup_view_model.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late final GlobalKey<FormState> _formKey;
  late final SignupViewModel _viewModel;

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _surnameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _viewModel = SignupViewModel();
  }

  String? _textFieldValidator(String? value) {
    if (value.isNullOrEmpty) {
      return Strings.typeSth;
    }
    return null;
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
        customPageTitle(context, Strings.signup),
        context.emptySizedHeightBoxNormal,
        customTextField(Strings.name, _nameTextController,
            Icons.account_box_outlined, _textFieldValidator),
        context.emptySizedHeightBoxNormal,
        customTextField(Strings.surname, _surnameTextController,
            Icons.account_box_outlined, _textFieldValidator),
        context.emptySizedHeightBoxNormal,
        customTextField(Strings.email, _emailTextController,
            Icons.email_outlined, _textFieldValidator),
        context.emptySizedHeightBoxNormal,
        customTextField(Strings.password, _passwordTextController,
            Icons.lock_outline, _textFieldValidator),
        context.emptySizedHeightBoxNormal,
        CustomButton(
          widget: context.watch<SignupViewModel>().isLoading
              ? const CircularProgressIndicator()
              : const Text(Strings.save),
          onClick: () async {
            if (_formKey.currentState?.validate() ?? false) {
              bool isSignup = await _viewModel.signUp(
                  _nameTextController.text,
                  _surnameTextController.text,
                  _emailTextController.text,
                  _passwordTextController.text);
              if (isSignup && context.mounted) {
                CustomNavigator.pushAndRemoveUntil(context, Strings.mainRoute);
              }
            }
          },
        )
      ],
    );
  }
}
