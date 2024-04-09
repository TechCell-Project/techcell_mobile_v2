class Validator {
  static String? validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '🚩 Nhập đúng địa chỉ email';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    if (value.length < 8) {
      return '🚩 Mật khẩu phải dài hơn hoặc bằng 8 kí tự';
    } else {
      return null;
    }
  }

  static String? validateText(String value) {
    if (value.isEmpty) {
      return '🚩 không được để trống';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String value) {
    if (value.length < 10 || value.length > 10) {
      return '🚩 Vui lòng nhập đúng số điện thoại';
    } else {
      return null;
    }
  }
}
