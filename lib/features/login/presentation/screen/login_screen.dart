import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/primary/primary_button.dart';
import 'package:mansour_store/core/util/constants/primary/primary_padding.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';
import 'package:mansour_store/core/util/cubit/home_states.dart';
import 'package:mansour_store/core/util/extensions/context_extension.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  // key for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: ColorsManager.textColor,
          ),
          onPressed: () {
            context.pop;
          },
        ),
        centerTitle: true,
        backgroundColor: ColorsManager.whiteColor,
      ),
      body: PrimaryPadding(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: homeCubit.emailController,
                cursorColor: ColorsManager.primaryColor,
                style: TextStylesManager.semiBold16,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );

                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStylesManager.medium16,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: ColorsManager.lightGreyColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: ColorsManager.lightGreyColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ),
              ),
              verticalSpace16,
              TextFormField(
                controller: homeCubit.passwordController,
                cursorColor: ColorsManager.primaryColor,
                style: TextStylesManager.semiBold16,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }

                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      color: ColorsManager.textColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  labelText: 'Password',
                  labelStyle: TextStylesManager.medium16,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: ColorsManager.lightGreyColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: ColorsManager.lightGreyColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ),
              ),
              verticalSpace40,
              BlocConsumer<HomeCubit, HomeStates>(
                listener: (context, state) {
                  if (state is LoginUserSuccessState) {
                    context.pop;
                  }
                },
                buildWhen: (prev, current) {
                  return current is LoginUserLoadingState || current is LoginUserErrorState || current is LoginUserSuccessState;
                },
                builder: (context, state) {
                  return PrimaryButton(
                    onPressed: () {
                      if (state is LoginUserLoadingState) {
                        return;
                      }

                      if (_formKey.currentState?.validate() ?? false) {
                        homeCubit.loginUser();
                      }
                    },
                    text: 'Login',
                    isLoading: state is LoginUserLoadingState,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
