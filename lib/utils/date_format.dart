import 'package:intl/intl.dart';

String formatDateTime(DateTime date) =>
    DateFormat('d MMMM y hh:mm aaa').format(date);
