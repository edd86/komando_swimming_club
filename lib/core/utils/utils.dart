class Utils {
  int calculateAge(DateTime dateOfBirth) {
    final DateTime now = DateTime.now();
    final int bMonth = dateOfBirth.month;
    final int bDay = dateOfBirth.day;
    if (now.month < bMonth) {
      return now.year - dateOfBirth.year - 1;
    }
    if (now.month == bMonth && now.day < bDay) {
      return now.year - dateOfBirth.year - 1;
    } else {
      return now.year - dateOfBirth.year;
    }
  }
}
