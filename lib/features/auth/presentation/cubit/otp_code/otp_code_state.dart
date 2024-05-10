part of 'otp_code_cubit.dart';

@immutable
abstract class OtpCodeState {}

class OtpCodeInitial extends OtpCodeState {}
class OtpCodeLoading extends OtpCodeState{}
class OtpCodeError extends OtpCodeState{
  final String message;

  OtpCodeError({required this.message});
}
class OtpCodeSuccess extends OtpCodeState{}
