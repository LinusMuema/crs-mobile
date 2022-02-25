import 'package:cached_network_image/cached_network_image.dart';
import 'package:crs/screens/profile/profile.controller.dart';
import 'package:crs/theme/dimens.dart';
import 'package:crs/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../components/loaders.dart';
import '../../theme/colors.dart';

class Profile extends GetView<ProfileController> {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var email = FormBuilderValidators.email(context);
    var required = FormBuilderValidators.required(context);
    var phone = FormBuilderValidators.minLength(context, 10);

    var phoneValidator = FormBuilderValidators.compose([phone]);
    var requiredValidator = FormBuilderValidators.compose([required]);
    var emailValidator = FormBuilderValidators.compose([required, email]);

    return Obx(() {
      var user = controller.user.value!;
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Profile',
                          style: heading1.copyWith(
                            fontSize: 25,
                          )),
                      const Spacer(),
                      TextButton(
                          onPressed: controller.logout,
                          child: Text(
                            'Logout',
                            style: heading1.copyWith(fontSize: 20),
                          ))
                    ],
                  ),
                ),
                Center(
                  child: CircleAvatar(
                    radius: 70.0,
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl: user.avatar,
                        width: Get.width,
                        fit: BoxFit.cover,
                        placeholder: (c, i) => threeBounce(color: black),
                      ),
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                ),
                verticalSpaceTiny,
                Text(
                  user.username,
                  style: heading1.copyWith(fontSize: 25),
                ),
                Text(
                  user.email,
                  style: heading3.copyWith(fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    user.phone,
                    style: heading3.copyWith(fontSize: 15),
                  ),
                ),
                verticalSpaceSmall,
                Container(
                  padding: mediumHInsets,
                  width: Get.width,
                  child: FormBuilder(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('username', style: heading1),
                        verticalSpaceTiny,
                        FormBuilderTextField(
                          name: 'username',
                          initialValue: user.username,
                          validator: requiredValidator,
                        ),
                        verticalSpaceSmall,
                        Text('email', style: heading1),
                        verticalSpaceTiny,
                        FormBuilderTextField(
                          name: 'email',
                          initialValue: user.email,
                          validator: emailValidator,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        verticalSpaceSmall,
                        Text('phone', style: heading1),
                        verticalSpaceTiny,
                        FormBuilderTextField(
                          name: 'phone',
                          initialValue: user.phone,
                          validator: phoneValidator,
                        ),
                        verticalSpaceSmall,
                        ElevatedButton(
                          onPressed: controller.updateProfile,
                          child: controller.loading.value
                              ? threeBounce()
                              : Text('update', style: body2),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget userDetails(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            title,
            style: heading1.copyWith(fontSize: 20),
          ),
        ),
        SizedBox(
          width: Get.width,
          height: 50,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: heading3.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
