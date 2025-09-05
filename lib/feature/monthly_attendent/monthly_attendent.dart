import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, String> _status = {
    DateTime.utc(2025, 5, 2): 'absent',
    DateTime.utc(2025, 5, 5): 'present',
    DateTime.utc(2025, 5, 6): 'present',
    DateTime.utc(2025, 5, 7): 'present',
    DateTime.utc(2025, 5, 8): 'holiday',
    // DateTime.utc(2025, 5, 11): 'present',
    DateTime.utc(2025, 5, 12): 'present',
    DateTime.utc(2025, 5, 13): 'present',
    DateTime.utc(2025, 5, 14): 'present',
    DateTime.utc(2025, 5, 15): 'present',
    DateTime.utc(2025, 5, 9): 'present',
    DateTime.utc(2025, 5, 1): 'absent',
    DateTime.utc(2025, 5, 16): 'leave',
  };
  int get totalAbsent =>
      _status.values.where((status) => status == 'absent').length;

  int get totalPresent =>
      _status.values.where((status) => status == 'present').length;

  int get totalLeave =>
      _status.values.where((status) => status == 'leave').length;
  int get totalHoliday =>
      _status.values.where((status) => status == 'holiday').length;

  String toKhmerNumber(int number) {
    const khmerDigits = ['០', '១', '២', '៣', '៤', '៥', '៦', '៧', '៨', '៩'];
    return number
        .toString()
        .split('')
        .map((e) => khmerDigits[int.parse(e)])
        .join('');
  }

  Color _getMarkerColor(String status) {
    switch (status) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'leave':
        return Colors.orange;
      case 'holiday':
        return Colors.blueAccent;
      default:
        return Colors.grey;
    }
  }

  String _buildCustomHeader(DateTime date) {
    const khmerMonths = [
      'មករា',
      'កម្ភៈ',
      'មីនា',
      'មេសា',
      'ឧសភា',
      'មិថុនា',
      'កក្កដា',
      'សីហា',
      'កញ្ញា',
      'តុលា',
      'វិច្ឆិកា',
      'ធ្នូ'
    ];

    const englishMonths = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    final englishMonth = englishMonths[date.month - 1];
    final khmerMonth = khmerMonths[date.month - 1];
    final year = date.year;

    return '$englishMonth ($khmerMonth) $year';
  }

  String getCurrentMonthInKhmer() {
    final now = DateTime.now();

    // English month name (e.g., May)
    String englishMonth = DateFormat.MMMM().format(now); // e.g. "May"

    // Khmer month names
    const khmerMonths = [
      '', // Index 0 (unused)
      'មករា',
      'កុម្ភៈ',
      'មីនា',
      'មេសា',
      'ឧសភា',
      'មិថុនា',
      'កក្កដា',
      'សីហា',
      'កញ្ញា',
      'តុលា',
      'វិច្ឆិកា',
      'ធ្នូ'
    ];

    String khmerMonth = khmerMonths[now.month]; // e.g. "ឧសភា"

    return "$englishMonth ($khmerMonth)";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        // backgroundColor: Colors.blueAccent,
        title: const Text("Kunmony's Attendance",
            style: TextStyle(
              fontSize: 17,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Student Attendance (តាមដានវត្តមានសិស្ស)',
                    style: TextStyle(
                      fontSize: 16,
                    )),
                Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                  color: Colors.black,
                )
              ],
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 188, 190, 190), // Line color
            thickness: 0.7, // Line thickness
            indent: 10, // Left margin
            endIndent: 10, // Right margin
          ),
          const SizedBox(
            height: 0,
          ),
          Container(
            margin:
                const EdgeInsets.all(10), // optional: spacing around calendar
            decoration: BoxDecoration(
              color: Colors.white, // ✅ Background color
              borderRadius: BorderRadius.circular(10), // ✅ Rounded corners
              boxShadow: [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TableCalendar(
              daysOfWeekHeight: 40,
              locale: 'km',
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: true, // ✅ Must be true to show the button
                formatButtonShowsNext: false,

                formatButtonDecoration: BoxDecoration(
                  color: Colors.white, // ✅ Button background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blueAccent),
                ),
                formatButtonTextStyle: const TextStyle(
                  color: Colors.blueAccent, // ✅ Button text color
                  fontWeight: FontWeight.bold,
                ),

                // ... your existing style
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(5),
                ),
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                leftChevronIcon: const Icon(Icons.chevron_left,
                    color: Colors.white, size: 25),
                rightChevronIcon: const Icon(Icons.chevron_right,
                    color: Colors.white, size: 25),

                titleTextFormatter: (date, locale) {
                  return _buildCustomHeader(date);
                },
                headerPadding: const EdgeInsets.symmetric(vertical: 3),
              ),
              availableCalendarFormats: const {
                CalendarFormat.month: '​ខែ',
                CalendarFormat.twoWeeks: '២ សប្តាហ៍',
                CalendarFormat.week: '១​ សប្តាហ៍',
              },
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, date, focusedDay) {
                  final status =
                      _status[DateTime.utc(date.year, date.month, date.day)];
                  final isWeekend = date.weekday == DateTime.saturday ||
                      date.weekday == DateTime.sunday;

                  return Center(
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: status != null
                            ? _getMarkerColor(status)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            color: isWeekend
                                ? Colors.red
                                : (status != null
                                    ? Colors.white
                                    : Colors.black),
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // const Spacer(),
          // const SizedBox(
          //   height: 20,
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(" Kunmony's Attendance month : ${getCurrentMonthInKhmer()}",
                    style: const TextStyle(
                      fontSize: 16,
                    )),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 27,
                )
              ],
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 188, 190, 190), // Line color
            thickness: 0.7, // Line thickness
            indent: 10, // Left margin
            endIndent: 10, // Right margin
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryBox("វត្តមាន", totalPresent, Colors.green),
                const SizedBox(width: 5),
                _buildSummaryBox("អវត្តមាន", totalAbsent, Colors.red),
                const SizedBox(width: 5),
                _buildSummaryBox("ច្បាប់", totalLeave, Colors.orange),
                const SizedBox(width: 5),
                _buildSummaryBox("ថ្ងៃបុណ្យ", totalHoliday,
                    const Color.fromARGB(255, 63, 112, 237)),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSummaryBox(String label, int count, Color color) {
    return Container(
      width: 95,
      height: 110,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$count",
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
