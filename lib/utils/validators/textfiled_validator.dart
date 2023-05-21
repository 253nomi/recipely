class TextValidators {
  static String? validateEmail(String? value) {
    var errorMsg = 'Empty Email';
    var errorMsg2 = 'Invalid Email';

    if (value!.isEmpty) {
      return errorMsg;
    } else {
      final emailValidate =
          RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value);

      if (!emailValidate) {
        return errorMsg2;
      } else {
        return null;
      }
    }
  }

  static String? passwordValidated(String? value) {
    var errorMsg = 'Empty Pass';
    var errorMsg2 = 'Password should be 8 characters';

    if (value!.isEmpty) {
      return errorMsg;
    } else {
      final passValidate = value.length == 8;

      if (!passValidate) {
        return errorMsg2;
      } else {
        return null;
      }
    }
  }
}
