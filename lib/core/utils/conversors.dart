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
}
