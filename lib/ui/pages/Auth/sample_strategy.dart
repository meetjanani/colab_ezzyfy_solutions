import 'package:otp_autofill/otp_autofill.dart';


class SampleStrategy extends OTPStrategy {
  @override
  Future<String> listenForCode() {
    return Future.delayed(
      const Duration(seconds: 4),
      () => '112233 is your verification code for colab-sample.firebaseapp.com.'
          'ltcOOJ/OPI4',
    );
  }
}