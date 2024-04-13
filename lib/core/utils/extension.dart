// ignore_for_file: unnecessary_string_escapes

extension StringExtension on String? {
  bool isNotNullOrEmpty() => this != null && this!.isNotEmpty;

  String toSimpleText() =>
      isNotNullOrEmpty() ? this!.replaceAll("----", "") : "";

  double toDouble() => isNotNullOrEmpty() ? double.parse(this ?? "") : 0.0;

  double toBoolInteger() => isNotNullOrEmpty()
      ? this!.toLowerCase() == "true"
          ? 1
          : 0
      : 0;

  int toInt() => isNotNullOrEmpty() ? int.parse(this ?? "0") : 0;

  bool toBool() => isNotNullOrEmpty()
      ? this!.toLowerCase() == "true" || this == "0"
          ? true
          : false
      : false;

  bool isValidEmail() => isNotNullOrEmpty()
      ? RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(this ?? "")
      : false;

  bool isEmail() => isNotNullOrEmpty()
      ? RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(this ?? "")
      : false;

  bool isName() => isNotNullOrEmpty()
      ? RegExp(r'^[a-zA-Z0-9]{1,35}$').hasMatch(this ?? "")
      : false;

  bool isUserName() => isNotNullOrEmpty()
      ? RegExp(r"^[a-zA-Z0-9]+$").hasMatch(this ?? "")
      : false;

  bool isAddress() => isNotNullOrEmpty()
      ? RegExp(r'^[a-zA-Z0-9/\\' '(),-\s]{2,255}').hasMatch(this ?? "")
      : false;

  bool isZipCode() => isNotNullOrEmpty()
      ? RegExp(r'^\d{5}([\-]?\d{4})?$').hasMatch(this ?? "")
      : false;

  bool isZip5Code() =>
      isNotNullOrEmpty() ? RegExp(r'^\d{5}').hasMatch(this ?? "") : false;

  bool isPassword() => isNotNullOrEmpty()
      ? RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$').hasMatch(this ?? "")
      : false;

  bool isPhone() => isNotNullOrEmpty()
      ? RegExp(
              r'^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$')
          .hasMatch(this ?? "")
      : false;

  String capitalizeFirst() => isNotNullOrEmpty()
      ? "${this![0].toUpperCase()}${this!.substring(1)}"
      : "";
}

extension Numeric on String {
  bool get isNumeric => num.tryParse(this) != null ? true : false;

  int get toBoolNumeric => toString().toLowerCase() == 'true' ? 1 : 0;
}

extension Bool on String {
  int get toBoolNumeric => toString().toLowerCase() == 'true' ? 1 : 0;

  String get toBoolString => toString().toLowerCase() == 'true' ? "1" : "0";

  bool get toNumericStringBool =>
      toString().toLowerCase() == '1' ? true : false;

  bool get toStringBool => toString().toLowerCase() == 'true' ? true : false;
}
