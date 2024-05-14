import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_management/config/routes/routes.dart';
import 'package:user_management/modules/authentication/bloc/auth_bloc.dart';
import 'package:user_management/modules/authentication/view/screen/signup.dart';
import 'package:user_management/utils/form_validator.dart';
import 'package:user_management/widget/dialog/ciruclar_progress_indicator.dart';
import 'package:user_management/widget/dialog/custom_snackbar.dart';
import 'package:user_management/widget/textfield/custom_text_form_field.dart';
import 'package:user_management/widget/textfield/input_field_decoration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool agreedToTerms = false;
  bool hidePassword = true;
  BehaviorSubject<bool> valid = BehaviorSubject<bool>.seeded(false);

  @override
  void dispose() {
    valid.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is LoginSuccess) {
            context.pop();
            context.pushReplacementNamed(AppRoute.home);
          }
          if (state is LoginLoading) {
            circularProgressIndicator(context);
          }
          if (state is LoginError) {
            context.pop();
            CustomSnackbar.show(context, 'User not found');
          }
        },
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                height: 90,
                width: 80,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(100),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  alignment: Alignment.bottomRight,
                  height: 90,
                  width: 80,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const CircleAvatar(
                        radius: 32,
                        backgroundColor: Color(0xffE1ABA9),
                        child: Text(
                          'B',
                          style: TextStyle(
                              fontFamily: 'MsMadi',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Welcome Back!',
                        style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Please sign in to your account',
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 20.0),
                      InputTextField(
                        controller: emailController,
                        validation: (String? val) {
                          final String? error =
                              FormValidator.validateEmail(val);
                          if (error == null) {
                            valid.add(true);
                          } else {
                            valid.add(false);
                          }
                          return error;
                        },
                        decoration:
                            CustomInputDecoration.outlineInputDecoration(
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Color(0xffe1aba9),
                                ),
                                hintText: 'example@gmail.com',
                                labelText: 'Email'),
                      ),
                      const SizedBox(height: 20.0),
                      InputTextField(
                        maxLines: 1,
                        controller: passwordController,
                        obscureText: hidePassword,
                        validation: (String? val) {
                          final String? error =
                              FormValidator.validatePassword(val);
                          if (error == null) {
                            valid.add(true);
                          } else {
                            valid.add(false);
                          }
                          return error;
                        },
                        decoration:
                            CustomInputDecoration.outlineInputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Color(0xffe1aba9),
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      hidePassword = !hidePassword;
                                      setState(() {});
                                    },
                                    icon: !hidePassword
                                        ? const Icon(
                                            Icons.visibility,
                                            color: Color(0xffe1aba9),
                                          )
                                        : const Icon(
                                            Icons.visibility_off,
                                            color: Color(0xffe1aba9),
                                          )),
                                hintText: 'Password',
                                labelText: 'Password'),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: theme.colorScheme.scrim),
                            )),
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: agreedToTerms,
                            onChanged: (bool? value) {
                              setState(() {
                                agreedToTerms = value!;
                              });
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              style: theme.textTheme.bodyMedium,
                              children: <InlineSpan>[
                                const TextSpan(text: 'I agree with the '),
                                TextSpan(
                                  text: 'terms & conditions',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          theme.colorScheme.primary),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: StreamBuilder<bool>(
                                stream: valid.stream,
                                builder: (BuildContext context,
                                    AsyncSnapshot<bool> snapshot) {
                                  return FilledButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                      onPressed: validateButton(snapshot)
                                          ? loginRequested
                                          : null,
                                      child: const Text('Sign In'));
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Or Sign in Using',
                        style: theme.textTheme.labelMedium
                            ?.copyWith(color: theme.colorScheme.tertiary),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 20,
                        children: <Widget>[
                          const Material(
                            elevation: 1.4,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Icon(
                                Icons.apple,
                                size: 28,
                              ),
                            ),
                          ),
                          Material(
                            elevation: 1.4,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Image.asset(
                                  'assets/images/g.png',
                                  width: 25,
                                  height: 25,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      const SignUpPage()));
                        },
                        child: RichText(
                          text: TextSpan(
                            style: theme.textTheme.bodyMedium,
                            children: <InlineSpan>[
                              const TextSpan(text: "Don't have an Account? "),
                              TextSpan(
                                text: 'Sign Up',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor: theme.colorScheme.primary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginRequested() {
    BlocProvider.of<AuthBloc>(context).add(LoginRequested(
        email: emailController.text, password: passwordController.text));
  }

  bool validateButton(AsyncSnapshot<bool> snapshot) {
    return (snapshot.hasData && snapshot.data!) &&
        agreedToTerms &&
        (emailController.text.isNotEmpty && passwordController.text.isNotEmpty);
  }
}
