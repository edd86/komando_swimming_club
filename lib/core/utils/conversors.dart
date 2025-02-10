class Conversors {
  static String dateToString(DateTime date) {
    int year = date.year;
    int month = date.month;
    int day = date.day;
    String newDay;
    String newMonth;
    day < 10 ? newDay = '0$day' : newDay = day.toString();
    month < 10 ? newMonth = '0$month' : newMonth = month.toString();
    return '$newDay/$newMonth/$year';
  }

  static String timeToString(DateTime date) {
    int hour = date.hour;
    int minute = date.minute;
    String newHour;
    String newMinute;
    hour < 10 ? newHour = '0$hour' : newHour = hour.toString();
    minute < 10 ? newMinute = '0$minute' : newMinute = minute.toString();
    return '$newHour:$newMinute';
  }
}
