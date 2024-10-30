import 'package:scanguard/utils/imports.dart';

class Validation {
  // Email text field validation

  static emptuValidation(value) {
    if (value.isEmpty) {
      return "Please enter data ";
    }
  }

  static emailValidation(value) {
    if (value.isEmpty) {
      return "Field Cannot be empty";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Please enter valid email";
    }

    return null;
  }

  static passwordValidation(value) {
    if (value.isEmpty) {
      return "Field can not be empty";
    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Password must contain only numeric characters';
    } else if (value.length < 6) {
      return 'Password must be at least 6 digits long';
    }

    return null;
  }
}

/// Input formatter that ensures only one space between words
class SingleSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    // Don't allow first character to be a space
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    } else if (oldValue.text.isEmpty && newValue.text == ' ') {
      return oldValue;
    } else if (oldValue.text.endsWith(' ') && newValue.text.endsWith('  ')) {
      return oldValue;
    }

    return newValue;
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}
