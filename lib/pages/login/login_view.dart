import 'package:blog_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../utils/custom_navigator.dart';
import '../../utils/strings.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_texts.dart';
import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  late final GlobalKey<FormState> _formKey;
  late final LoginViewModel _viewModel;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _viewModel = LoginViewModel();
  }

  //email ve password textfieldları için doğrulama
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
        return Padding(
          padding: context.horizontalPaddingNormal,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: SizedBox(
              height: context.height,
              child: _titlesAndInputsColumn(context),
            )),
          ),
        );
      },
    ));
  }

  Column _titlesAndInputsColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        customPageTitle(context, Strings.helloText),
        context.emptySizedHeightBoxNormal,
        customTextField(Strings.email, emailTextController,
            Icons.email_outlined, _textFieldValidator),
        context.emptySizedHeightBoxNormal,
        customTextField(Strings.password, passwordTextController,
            Icons.lock_outline, _textFieldValidator),
        context.emptySizedHeightBoxNormal,
        CustomButton(
          widget: context.watch<LoginViewModel>().isLoading
              ? const CircularProgressIndicator()
              : const Text(Strings.login),
          onClick: () async {
            if (_formKey.currentState?.validate() ?? false) {
              bool isLogin = await _viewModel.login(
                  emailTextController.text, passwordTextController.text);
              if (isLogin && context.mounted) {
                CustomNavigator.pushAndRemoveUntil(context, Strings.mainRoute);
              }
            }
          },
        ),
        context.emptySizedHeightBoxNormal,
        _signupButton(context)
      ],
    );
  }

  Row _signupButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          Strings.dontHaveAccount,
          style: TextStyle(),
        ),
        context.emptySizedWidthBoxLow,
        InkWell(
          onTap: () {
            CustomNavigator.pushTo(context, Strings.signupRoute);
          },
          child: Text(
            Strings.signup,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
