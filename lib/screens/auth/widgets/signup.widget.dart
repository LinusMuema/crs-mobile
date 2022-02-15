import 'package:crs/components/loaders.dart';
import 'package:crs/screens/auth/auth.controller.dart';
import 'package:crs/theme/colors.dart';
import 'package:crs/theme/dimens.dart';
import 'package:crs/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class Signup extends GetWidget<AuthController> {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var confirm = controller.confirmHidden.value;
      var hidden = controller.passwordHidden.value;

      var confirmIcon = confirm ? Icons.visibility_off : Icons.visibility;
      var passwordIcon = hidden ? Icons.visibility_off : Icons.visibility;

      var email = FormBuilderValidators.email(context);
      var required = FormBuilderValidators.required(context);

      var passwordValidator = FormBuilderValidators.compose([required]);
      var emailValidator = FormBuilderValidators.compose([required, email]);

      return Center(
        child: FormBuilder(
          key: controller.signupKey,
          child: Padding(
            padding: largeInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Signup',
                  style: heading1.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceRegular,
                FormBuilderTextField(
                  name: 'email',
                  validator: emailValidator,
                  valueTransformer: (String? value) {
                    return value!.trim().toLowerCase();
                  },
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
                      icon: Icon(passwordIcon),
                      onPressed: controller.passwordHidden.toggle,
                    ),
                  ),
                ),
                verticalSpaceSmall,
                FormBuilderTextField(
                  name: 'confirm',
                  obscureText: confirm,
                  validator: passwordValidator,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelStyle: body3,
                    label: const Text('Confirm password'),
                    suffixIcon: IconButton(
                      color: grey,
                      icon: Icon(confirmIcon),
                      onPressed: controller.confirmHidden.toggle,
                    ),
                  ),
                ),
                verticalSpaceRegular,
                ElevatedButton(
                  onPressed: controller.signup,
                  child: controller.loading.value
                      ? threeBounce()
                      : Text('signup', style: body2),
                ),
                verticalSpaceSmall,
                GestureDetector(
                  onTap: () => controller.changePage(0),
                  child: Text('Already have an account?', style: body1),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
