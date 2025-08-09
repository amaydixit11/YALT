import 'package:intl/intl.dart';

class DateUtils {
  static DateTime normalizeToLocalDate(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }
  
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
  
  static String formatDateDisplay(DateTime date) {
    final now = DateTime.now();
    final today = normalizeToLocalDate(now);
    final yesterday = today.subtract(const Duration(days: 1));
    final normalizedDate = normalizeToLocalDate(date);
    
    if (normalizedDate == today) {
      return 'Today';
    } else if (normalizedDate == yesterday) {
      return 'Yesterday';
    } else if (now.difference(date).inDays < 7) {
      return DateFormat('EEEE').format(date);
    } else {
      return DateFormat('MMM d').format(date);
    }
  }
  
  static String formatDateLong(DateTime date) {
    return DateFormat('EEEE, MMMM d, yyyy').format(date);
  }
  
  static DateTime parseDate(String dateString) {
    return DateTime.parse(dateString);
  }
  
  static bool isSameDay(DateTime date1, DateTime date2) {
    return normalizeToLocalDate(date1) == normalizeToLocalDate(date2);
  }
  
  static List<DateTime> getDaysInRange(DateTime start, DateTime end) {
    final days = <DateTime>[];
    var current = normalizeToLocalDate(start);
    final endNormalized = normalizeToLocalDate(end);
    
    while (current.isBefore(endNormalized) || current.isAtSameMomentAs(endNormalized)) {
      days.add(current);
      current = current.add(const Duration(days: 1));
    }
    
    return days;
  }
  
  static DateTime getStartOfYear([DateTime? date]) {
    final target = date ?? DateTime.now();
    return DateTime(target.year, 1, 1);
  }
  
  static DateTime getStartOfMonth([DateTime? date]) {
    final target = date ?? DateTime.now();
    return DateTime(target.year, target.month, 1);
  }
}