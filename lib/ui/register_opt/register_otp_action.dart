part of 'register_opt_page.dart';

extension RegisterOtpAction on _RegisterOptPageState {
  Future<void> _handleGoogleSignIn(RegisterOptState state) async {
    // await _pbLoading!
    //     .show(msg: Lang.started_loading_please_wait.tr(), max: 100);
    try {
      final socialLoginDataResult = await _firebaseWrapper.handleGoogleSignIn();
      socialLoginDataResult.fold((l) {
        _pbLoading!.close();
        UIUtil.showToast(Lang.home_fail_to_sign_in_social.tr());
      }, (socialLoginData) {
        if (socialLoginData.email != null) {
          _registerOptBloc.add(RegisterByEmail(
              firstName: socialLoginData.firstName?? socialLoginData.name,
              lastName: socialLoginData.lastName ?? '',
              socialId: socialLoginData.id,
              dob: DateTime.now()
                  .subtract(const Duration(days: 365 * 13 + 4))
                  .toString(),
              hasSocialEmail: 1,
              type: getTypeByEnum(RegisterEnum.GOOGLE),
              email: socialLoginData.email,
              maritalId: state.maritalStatusSelected?.id.toString(),
              dialCode: state.countrySelected?.dialCode));
        } else {
          _pbLoading?.close();
          NavigateUtil.openPage(context, RegisterPage.routeName,
              argument: {'type': RegisterEnum.GOOGLE, 'data': socialLoginData});
        }
      });
    } catch (error) {
      _pbLoading!.close();
    }
  }

  //Take action Facebook SignIn
  Future<void> _handleFacebookSignIn(RegisterOptState state) async {
    await _pbLoading!
        .show(msg: Lang.started_loading_please_wait.tr(), max: 100);
    try {
      final socialLoginDataResult =
          await _firebaseWrapper.handleFacebookSignIn();
      socialLoginDataResult.fold((l) {
        _pbLoading!.close();
        UIUtil.showToast(Lang.home_fail_to_sign_in_social.tr());
      }, (socialLoginData) {
        if (socialLoginData.email != null) {
          _registerOptBloc.add(RegisterByEmail(
              firstName: socialLoginData.firstName,
              lastName: socialLoginData.lastName,
              socialId: socialLoginData.id,
              dob: DateTime.now()
                  .subtract(const Duration(days: 365 * 13 + 4))
                  .toString(),
              hasSocialEmail: 1,
              type: getTypeByEnum(RegisterEnum.FACEBOOK),
              email: socialLoginData.email,
              maritalId: state.maritalStatusSelected!.id.toString(),
              dialCode: state.countrySelected!.dialCode));
        } else {
          _pbLoading!.close();
          NavigateUtil.openPage(context, RegisterPage.routeName, argument: {
            'type': RegisterEnum.FACEBOOK,
            'data': socialLoginData
          });
        }
      });
    } catch (error) {
      _pbLoading!.close();
    }
  }

  ///Take action Apple SignIn
  Future<void> _handleAppleSignIn(RegisterOptState state) async {
    await _pbLoading!
        .show(max: 100, msg: Lang.started_loading_please_wait.tr());
    try {
      final socialLoginDataResult = await _firebaseWrapper.handleAppleSignIn();
      socialLoginDataResult.fold((l) {
        _pbLoading!.close();
        UIUtil.showToast(Lang.home_fail_to_sign_in_social.tr());
      }, (socialLoginData) {
        if (socialLoginData.email != null) {
          var firstName = socialLoginData.firstName;
          var lastName = socialLoginData.lastName;
          if (firstName != null && firstName.isEmpty && lastName != null && lastName.isEmpty) {
            firstName = socialLoginData.email.split('@')[0];
            lastName =
                socialLoginData.email.split('@')[1].replaceAll('.com', '');
          }
          _registerOptBloc.add(RegisterByEmail(
              firstName: firstName,
              lastName: lastName,
              socialId: socialLoginData.id,
              dob: DateTime.now()
                  .subtract(const Duration(days: 365 * 13 + 4))
                  .toString(),
              hasSocialEmail: 1,
              type: getTypeByEnum(RegisterEnum.APPLE),
              email: socialLoginData.email,
              maritalId: state.maritalStatusSelected!.id.toString(),
              dialCode: state.countrySelected!.dialCode));
        } else {
          _pbLoading!.close();
          NavigateUtil.openPage(context, RegisterPage.routeName,
              argument: {'type': RegisterEnum.APPLE, 'data': socialLoginData});
        }
      });
    } catch (error) {
      _pbLoading!.close();
    }
  }
}
