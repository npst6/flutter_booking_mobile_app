///Note validate_email.dart

///Validate email
class ValidateData {
  ///Check email format
  static String validEmail(String text) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (text.isEmpty) {
      return 'Email field cannot be left blank';
    } else if (!regex.hasMatch(text)) {
      return 'Email invalidate';
    } else {
      return null;
    }
  }

  ///Check empty fields
  static String validEmpty(String text) {
    return text.isEmpty ? 'The field cannot be left blank' : null;
  }
}
