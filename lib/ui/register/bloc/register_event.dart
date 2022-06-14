part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class FirstNameChanged extends RegisterEvent {
  final String? firstName;

  FirstNameChanged({ this.firstName});

  @override
  List<Object> get props => [firstName!];
}

class LastNameChanged extends RegisterEvent {
  final String? lastName;

  LastNameChanged({ this.lastName});

  @override
  List<Object> get props => [lastName!];
}

class OnSelectDOB extends RegisterEvent {
  final DateTime? selectedDate;

  OnSelectDOB(this.selectedDate);
}

class DoCountDown extends RegisterEvent {}

class StartCountDown extends RegisterEvent {}

class DoResendCode extends RegisterEvent {}

class HasSocialEmail extends RegisterEvent {}

class LoadCountryCode extends RegisterEvent {}

class OnSelectMarital extends RegisterEvent {
  final MaritalStatus maritalStatus;

  OnSelectMarital({ required this.maritalStatus});

  @override
  List<Object> get props => [maritalStatus];
}

class OnSelectCountryCode extends RegisterEvent {
  final Country? countryStatus;

  OnSelectCountryCode({ this.countryStatus});

  @override
  List<Object> get props => [countryStatus!];
}

class EmailChanged extends RegisterEvent {
  final String? email;

  EmailChanged({ this.email});

  @override
  List<Object> get props => [email!];
}

class PhoneChanged extends RegisterEvent {
  final String? phone;

  PhoneChanged({ this.phone});

  @override
  List<Object> get props => [phone!];
}

class PasswordChanged extends RegisterEvent {
  final String? password;

  PasswordChanged({ this.password});

  @override
  List<Object> get props => [password!];
}

class ConfirmPasswordChanged extends RegisterEvent {
  final String? confirmPassword;
  final String? password;

  ConfirmPasswordChanged(
      { this.password,  this.confirmPassword});

  @override
  List<Object> get props => [confirmPassword!, password!];
}

class SubmitVerifyCode extends RegisterEvent {
  final String? code;
  final String? tokenCode;

  SubmitVerifyCode({this.code, this.tokenCode});
}

class DoLogin extends RegisterEvent {
  final String? accessToken;

  DoLogin(this.accessToken);
}

class DoBackRoute extends RegisterEvent {}

class InformationButtonPressed extends RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? dialCode;
  final String? dob;
  final String? maritalId;
  final String? type;
  final String? socialId;
  final int? hasSocialEmail;
  final String? password;

  const RegisterButtonPressed(
      { this.firstName,
       this.lastName,
       this.email,
       this.dialCode,
       this.phone,
       this.dob,
       this.maritalId,
       this.type,
       this.socialId,
       this.hasSocialEmail,
       this.password});

  @override
  List<Object> get props => [
        firstName!,
        lastName!,
        email!,
        phone!,
        dialCode!,
        dob!,
        maritalId!,
        type!,
        socialId!,
        hasSocialEmail!,
        password!
      ];

  @override
  String toString() =>
      'LoginButtonPressed { username: $firstName, password: $password }';
}
