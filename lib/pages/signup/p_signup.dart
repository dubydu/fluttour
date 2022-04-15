import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/generated/l10n.dart';
import 'package:fluttour/pages/signup/signup_bloc.dart';
import 'package:fluttour/pages/signup/signup_delegate.dart';
import 'package:fluttour/pages/signup/signup_event.dart';
import 'package:fluttour/pages/base/p_material.dart';
import 'package:fluttour/pages/signup/signup_state.dart';
import 'package:fluttour/utils/extension/app_extension.dart';
import 'package:fluttour/utils/extension/state_extension.dart';
import 'package:fluttour/utils/other/dynamic_size.dart';
import 'package:fluttour/utils/widgets/w_auth_textfield.dart';
import 'package:avoid_keyboard/avoid_keyboard.dart';
import 'package:fluttour/utils/widgets/w_header.dart';
import 'package:fluttour/utils/widgets/w_primary_button.dart';
import 'package:fluttour/app_define/app_route.dart';

class PSignUp extends StatefulWidget {
  @override
  _PSignUpState createState() => _PSignUpState();
}

class _PSignUpState extends State<PSignUp> with SignUpDelegate, DynamicSize {

  /// Properties
  late SignUpBloc _signUpBloc;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _signUpBloc = BlocProvider.of<SignUpBloc>(context, listen: false);
      _signUpBloc.delegate = this;
    });
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
  }

  _obscureTextEvent({required bool visibility}) {
    _signUpBloc.add(SignUpObscureTextEvent(isObscure: visibility));
  }

  List<String?> _getTextFieldsValue() {
    final String? name = _nameController.text;
    final String? email = _emailController.text;
    final String? pwd = _passwordController.text;
    return [name, email, pwd];
  }

  _textFieldsDidChangeEvent() {
    _signUpBloc.add(SignUpFormInputEvent(
        name: _getTextFieldsValue()[0],
        email: _getTextFieldsValue()[1],
        pwd: _getTextFieldsValue()[2]));
  }

  _saveProfile() {
    _signUpBloc.add(SignUpSavingEvent(
        name: _getTextFieldsValue()[0],
        email: _getTextFieldsValue()[1],
        pwd: _getTextFieldsValue()[2]));
  }

  @override
  Widget build(BuildContext context) {
    initDynamicSize(context);
    return PMaterial(
        child: Container(
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
                          height: 70.H,
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
                                    _textFieldsDidChangeEvent();
                                  }),
                              SizedBox(height: 10.H),
                              WAuthTextField(controller: _nameController,
                                  labelText: S.of(context).character,
                                  obscureText: false,
                                  isSecurityTextField: false,
                                  onChange: (text) async {
                                    _textFieldsDidChangeEvent();
                                  }),
                              SizedBox(height: 10.H),
                              _buildPwdWidget(context)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 32.W,
                              right: 32.W,
                              top: 20.H),
                          child: Column(
                            children: <Widget>[
                              _buildSaveButtonWidget(context)
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

  Widget _buildPwdWidget(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (_, state) {
          return state is SignUpObscureTextState;
        },
        builder: (context, state) {
          bool isObscure() {
            if (state is SignUpObscureTextState) {
              return state.isObscure;
            } else {
              return false;
            }
          }
          return WAuthTextField(
              controller: _passwordController,
              labelText: S.of(context).password,
              obscureText: isObscure(),
              isSecurityTextField: true,
              onPress: (visibility) async {
                _obscureTextEvent(visibility: visibility);
              },
              onChange: (text) async {
                _textFieldsDidChangeEvent();
              });
        }
    );
  }

  Widget _buildSaveButtonWidget(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (_, state) {
        return state is SignUpSaveButtonState;
      },
      builder: (context, state) {
        List<bool> buttonState() {
          if (state is SignUpSaveButtonState) {
            return [state.isValidate, state.isLoading];
          } else {
            return [false, false];
          }
        }
        return WPrimaryButton(
             title: S.of(context).go,
             isSelected: buttonState()[0],
             onPress: () async {
               _saveProfile();
             },
             isLoading: buttonState()[1]
         );
      },
    );
  }

  @override
  Future<void> didSignUpFailed(String mgs) async {
    return await showErrorDialog('<${S.of(context).flut_tour}>', mgs);
  }

  @override
  Future<void> didSignUpSuccess() async {
    context.navigator()?.pushNamedAndRemoveUntil(
        AppRoute.routeHome, (route) => false);
  }

  /*
  Widget _listenSignUpState() {
    return BlocListener<SignUpBloc, SignUpState> (
      listenWhen: (_, state) {
        return (state is SignUpSuccessState
            || state is SignUpErrorState);
      },
      listener: (context, state) async {
        if (state is SignUpSuccessState) {
          context.navigator()?.pushNamedAndRemoveUntil(AppRoute.routeHome, (route) => false);
        } else if (state is SignUpErrorState) {
          await showErrorDialog('<${S.of(context).flut_tour}>', state.mgs);
        }
      },
      child: Container(),
    );
  }
  */
}