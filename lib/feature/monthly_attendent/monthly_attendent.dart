import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({super.key, required this.data});
  Map<String, dynamic> data;

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, String> _status = {}; // <-- Now dynamic from API

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAttendance();
  }

  Future<void> _fetchAttendance() async {
    try {
       setState(() {
          _isLoading = true;
        });

      final year = _focusedDay.year;
      final month = _focusedDay.month;

      final url =
          "https://bit-g1.npit-edu.com/api/student/${widget.data["student_id"]}/attendance?year=$year&month=$month";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        Map<DateTime, String> fetchedStatus = {};

        // for (var dayEntry in jsonData["calendar"]) {
        // final dayKey = dayEntry.keys.first; // e.g. "1"
        // final details = dayEntry[dayKey];

        // final date = DateTime.utc(year, month, int.parse(dayKey));
        for (var dayEntry in jsonData["calendar"]) {
          final dayKey = dayEntry.keys.first; // e.g. "1"
          final details = dayEntry[dayKey];

          final date = DateTime.utc(year, month, int.parse(dayKey));
          final today = DateTime.now();

          // 🚫 Skip future dates (exclude next days)
          if (date.isAfter(DateTime(today.year, today.month, today.day))) {
            continue;
          }

          // Only track past and today
          if (details["is_holiday"] == true) {
            fetchedStatus[date] = "holiday";
          } else if (details["is_permission"] == true) {
            fetchedStatus[date] = "leave";
          } else if (details["is_joined"] == true) {
            fetchedStatus[date] = "present";
          } else if (details["is_weekend"] == true) {
            fetchedStatus[date] = "weekend";
          } else {
            fetchedStatus[date] = "absent";
          }
        }
        // }

        setState(() {
          _status = fetchedStatus;
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to load attendance");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint("Error fetching attendance: $e");
    }
  }

  // Get totals
  int get totalAbsent =>
      _status.values.where((status) => status == 'absent').length;

  int get totalPresent =>
      _status.values.where((status) => status == 'present').length;

  int get totalLeave =>
      _status.values.where((status) => status == 'leave').length;

  int get totalHoliday =>
      _status.values.where((status) => status == 'holiday').length;

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
      case 'weekend':
        return Colors.white;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("${widget.data["student_name"]}'s Attendance",
            style: TextStyle(fontSize: 17)),
      ),
      body: _isLoading
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text("Waiting ${widget.data["student_name"]} Attendance")
              ],
            ))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Student Attendance (តាមដានវត្តមានសិស្ស)',
                          style: TextStyle(fontSize: 16)),
                      Icon(Icons.calendar_month_outlined,
                          size: 20, color: Colors.black),
                    ],
                  ),
                ),
                const Divider(color: Color.fromARGB(255, 188, 190, 190)),
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 3))
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
                      formatButtonVisible: true,
                      formatButtonShowsNext: false,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      formatButtonTextStyle: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(5)),
                      titleTextStyle:
                          const TextStyle(color: Colors.white, fontSize: 17),
                      leftChevronIcon:
                          const Icon(Icons.chevron_left, color: Colors.white),
                      rightChevronIcon:
                          const Icon(Icons.chevron_right, color: Colors.white),
                      titleTextFormatter: (date, locale) {
                        return _buildCustomHeader(date);
                      },
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
                      setState(() {
                        _focusedDay = focusedDay;
                      });
                      _fetchAttendance(); // 🔹 reload when switching month
                    },
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, date, focusedDay) {
                        final status = _status[
                            DateTime.utc(date.year, date.month, date.day)];
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
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Kunmony's Attendance month : ${DateFormat.MMMM().format(_focusedDay)}",
                          style: const TextStyle(fontSize: 16)),
                      const Icon(Icons.arrow_drop_down, size: 27),
                    ],
                  ),
                ),
                const Divider(color: Color.fromARGB(255, 188, 190, 190)),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSummaryBox("វត្តមាន", totalPresent, Colors.green),
                      _buildSummaryBox("អវត្តមាន", totalAbsent, Colors.red),
                      _buildSummaryBox("ច្បាប់", totalLeave, Colors.orange),
                      _buildSummaryBox("ថ្ងៃបុណ្យ", totalHoliday,
                          const Color.fromARGB(255, 63, 112, 237)),
                    ],
                  ),
                ),
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
          Text("$count",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
