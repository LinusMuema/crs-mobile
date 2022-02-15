import 'package:crs/screens/auth/auth.controller.dart';
import 'package:crs/theme/colors.dart';
import 'package:crs/theme/dimens.dart';
import 'package:crs/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class Login extends GetWidget<AuthController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var hidden = controller.hidden.value;
      var icon = hidden ? Icons.visibility_off : Icons.visibility;

      var email = FormBuilderValidators.email(context);
      var required = FormBuilderValidators.required(context);

      var passwordValidator = FormBuilderValidators.compose([required]);
      var emailValidator = FormBuilderValidators.compose([required, email]);

      return Center(
        child: FormBuilder(
          key: controller.loginKey,
          child: Padding(
            padding: largeInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Login',
                  style: heading1.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceRegular,
                FormBuilderTextField(
                  name: 'email',
                  validator: emailValidator,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: const Text('Email address'),
                    labelStyle: body3,
                  ),
                ),
                verticalSpaceSmall,
                FormBuilderTextField(
                  name: 'password',
                  obscureText: hidden,
                  validator: passwordValidator,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelStyle: body3,
                    label: const Text('Password'),
                    suffixIcon: IconButton(
                      color: grey,
                      icon: Icon(icon),
                      onPressed: controller.hidden.toggle,
                    ),
                  ),
                ),
                verticalSpaceRegular,
                ElevatedButton(
                  onPressed: controller.login,
                  child: Text('login', style: body2),
                ),
                verticalSpaceSmall,
                GestureDetector(
                  onTap: () => controller.changePage(1),
                  child: Text("Don't have an account?", style: body1),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
