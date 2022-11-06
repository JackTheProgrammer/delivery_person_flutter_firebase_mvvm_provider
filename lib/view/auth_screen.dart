// ignore_for_file: unnecessary_null_comparison

import 'package:email_validator/email_validator.dart' show EmailValidator;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/color_schema.dart';
import '/viewmodel/auth_viewmodel.dart';
import '/view/show_delivery_details_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();

  String userEmail = "", userPassword = "";

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  Widget authenticationActionExpansionTile(
    String authenticationAction, {
    required VoidCallback authenticationButtonCallback,
  }) {
    bool userDetailsAcquired = (userEmail != "" && userEmail != null) &&
        (userPassword != "" && userPassword != null);
    bool disableCondition = userDetailsAcquired == false ||
            formStateKey.currentState!.validate() == false
        ? true
        : false;
    return AnimatedContainer(
      duration: const Duration(
        seconds: 1,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(
          colors: [
            kSemiLightDeepOrange!.withOpacity(0.2),
            kElevatedButtonColor!,
          ],
        ),
      ),
      child: ExpansionTile(
        title: Text(
          authenticationAction,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 9.0,
        ),
        children: [
          TextFormField(
            controller: emailTextController,
            onChanged: (usrEmail) {
              if (EmailValidator.validate(usrEmail, true) == true) {
                setState(() {
                  userEmail = usrEmail;
                });
              }
            },
            validator: (emailDeUser) {
              if (emailDeUser == "" || emailDeUser == null) {
                return "The value is not assigned/given as an input from user";
              }
              if (EmailValidator.validate(emailDeUser, true, true) == false) {
                debugPrint("$emailDeUser still not valid");
                return "Not a valid email address.";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Email",
              filled: true,
              fillColor: kFillingColor,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: passwordTextController,
            onChanged: (usrPwrd) {
              setState(() {
                userPassword = usrPwrd;
              });
            },
            validator: (value) {
              if (value == "" || value == null) {
                return "The value is not assigned/given as an input from user.";
              }
              if (value.length < 10) {
                return "Password should be at least 10 characters length.";
              }
              if (!value.contains('@') || !value.contains('*')) {
                return "Must have special characters '@' and '*' including.";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "password",
              filled: true,
              fillColor: kFillingColor,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          IgnorePointer(
            ignoring: disableCondition,
            child: ElevatedButton(
              onPressed: authenticationButtonCallback,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    disableCondition ? kDisabledColor : kElevatedButtonColor,
              ),
              child: Text(
                authenticationAction,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final deviceSize = mqData.size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: kFillingColor,
        body: Consumer<AuthViewModel>(
          builder: (context, authVModel, _) => Form(
            key: formStateKey,
            child: ListView(
              padding: EdgeInsets.only(
                left: 18.0,
                right: 18.0,
                top: deviceSize.height * 0.20,
              ),
              children: [
                authenticationActionExpansionTile(
                  "Sign Up",
                  authenticationButtonCallback: () {
                    formStateKey.currentState!.validate();
                    formStateKey.currentState!.save();

                    authVModel.signUp(
                      userEmail,
                      userPassword,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowDeliveryDetailsScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: deviceSize.height * 0.06,
                ),
                authenticationActionExpansionTile(
                  "Sign in",
                  authenticationButtonCallback: () {
                    formStateKey.currentState!.validate();
                    formStateKey.currentState!.save();

                    authVModel.signIn(
                      userEmail,
                      userPassword,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowDeliveryDetailsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
