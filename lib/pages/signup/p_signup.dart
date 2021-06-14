import 'package:flutter/material.dart';
import 'package:fluttour/generated/l10n.dart';
import 'package:fluttour/pages/signup/signup_delegate.dart';
import 'package:fluttour/pages/signup/signup_provider.dart';
import 'package:fluttour/utils/other/dynamic_size.dart';
import 'package:fluttour/utils/widgets/p_material.dart';
import 'package:fluttour/utils/extension/app_extension.dart';
import 'package:fluttour/utils/widgets/w_auth_textfield.dart';
import 'package:avoid_keyboard/avoid_keyboard.dart';
import 'package:fluttour/utils/widgets/w_header.dart';
import 'package:fluttour/utils/widgets/w_primary_button.dart';
import 'package:provider/provider.dart';
import 'package:fluttour/app_define/app_route.dart';

class PSignUp extends StatefulWidget {
  @override
  _PSignUpState createState() => _PSignUpState();
}

class _PSignUpState extends State<PSignUp> with DynamicSize, SignUpDelegate {
  /// Properties
  late SignupProvider _signupProvider;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _characterController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _signupProvider = Provider.of<SignupProvider>(context, listen: false);
      _signupProvider.delegate = this;
    });
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _characterController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    initDynamicSize(context);
    return PMaterial(child:
      Container(
        color: Colors.white,
        child: Container(
          child: Column(
            children: <Widget>[
              WHeader(title: S.of(context).app_title),
              AvoidKeyboard(
                spacing: 40.H,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 80.H,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 32.W,
                            right: 32.W),
                        child: Column(
                          children: <Widget>[
                            WAuthTextField(controller: _emailController,
                                labelText: S.of(context).email,
                                obscureText: false,
                                isSecurityTextField: false,
                                onChange: (text) async {
                                  _signupProvider.emailText = text;
                                }),
                            SizedBox(height: 20.H),
                            WAuthTextField(controller: _characterController,
                                labelText: S.of(context).character,
                                obscureText: false,
                                isSecurityTextField: false,
                                onChange: (text) async {
                                  _signupProvider.character = text;
                                }),
                            SizedBox(height: 20.H),
                            Selector<SignupProvider, bool>(
                                selector: (_, SignupProvider provider) => provider.passwordObscureTextState,
                                builder: (BuildContext context, bool data, __) {
                                  return WAuthTextField(controller: _passwordController,
                                      labelText: S.of(context).password,
                                      obscureText: data,
                                      isSecurityTextField: true,
                                      onPress: (visibility) async {
                                        context.read<SignupProvider>().passwordObscureTextState = visibility;
                                      },
                                      onChange: (text) async {
                                        _signupProvider.password = text;
                                      });
                                })
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 32.W,
                            right: 32.W,
                            top: 50.H),
                        child: Column(
                          children: <Widget>[
                            Consumer<SignupProvider>(
                                builder: (BuildContext context, SignupProvider provider, _) {
                                return WPrimaryButton(
                                  title: S.of(context).signup,
                                  isSelected: provider.isSignUpButtonEnable,
                                  onPress: () async {
                                    await _signupProvider.signup();
                                  },
                                  isLoading: provider.isSignUpButtonLoading);
                            }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  @override
  void didSignInFailed() {

  }

  @override
  void didSignInSuccess() {
    context.navigator()?.pushNamed(AppRoute.routeHome);
  }
}