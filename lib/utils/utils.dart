class Utils {
  static String dateTimeParseString(
      {required DateTime date, required bool setHours}) {
    String day = date.day.toString();
    String month = date.month.toString();
    String year = date.year.toString();
    String hour = date.hour.toString();
    String minutes = date.minute.toString();
    if (setHours) {
      return "${day.padLeft(2, "0")}/${month.padLeft(2, "0")}/$year às ${hour.padLeft(2, "0")}:${minutes.padLeft(2, "0")}";
    } else {
      return "${day.padLeft(2, "0")}/${month.padLeft(2, "0")}/$year";
    }
  }
}
