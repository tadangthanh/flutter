import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lession3456/vnua/subject.dart';

void main() async {
  // List<Subject>? subjects =
  //     await getScheduleByCode('6655264', 0); // hoc ki 0 la hoc ki 1
  // List<Subject> subjectsOnTheWeek =
  //     _getSubjectOnTheWeek(subjects: subjects ?? []);
  // List<Subject>subjectOnTheDay=_getSubjectOnTheDay(subjectsOnTheWeek, DateTime.now());
  print(DateTime.now());

}

bool _isHaveScheduleOnWeek(Subject subject, int currentWeek) {
  List<String> weeks = subject.week.split("");
  return weeks.length >= currentWeek && weeks[currentWeek - 1] != "-";
}

// tính thời gian giữa 2 date time
int _getCurrentDayFromStartDate(DateTime startDate, DateTime endDate) {
  return endDate.difference(startDate).inDays + 1;
}

int _getCurrentWeekStartFromStartDate(DateTime startDate) {
  DateTime currentDate = DateTime.now();
  return currentDate.difference(startDate).inDays ~/ 7 + 1;
}

List<Subject> _getSubjectOnTheWeek(
    {required List<Subject> subjects, int week = 0}) {
  List<Subject> result = [];
  for (var s in subjects) {
    if (_isHaveScheduleOnWeek(
        s, _getCurrentWeekStartFromStartDate(s.startDate) + week)) {
      result.add(s);
    }
  }
  return result;
}

List<Subject> _getSubjectOnTheDay(List<Subject> subjects, DateTime date) {
  List<Subject> result = [];
  Map<String, int> mapDay = {
    "Hai": 1,
    "Ba": 2,
    "Tư": 3,
    "Năm": 4,
    "Sáu": 5,
    "Bảy": 6,
    "CN": 7
  };
  for (var s in subjects) {
    if (mapDay[s.dayOfWeek] == date.weekday) result.add(s);
  }
  return result;
}

Future<List<Subject>?> getScheduleByCode(String code, int hocky) async {
  String baseUrl = 'https://daotao.vnua.edu.vn';
  String url = '$baseUrl/default.aspx?page=thoikhoabieu&sta=1&id=$code';

  var response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) {
    return null;
  }

  var document = parse(response.body);
  var element =
      document.getElementById("ctl00_ContentPlaceHolder1_ctl00_ddlChonNHHK");

  if (element == null) {
    return null;
  }

  var options = element.getElementsByTagName("option");
  List<String> listSemester =
      options.map((e) => e.attributes['value']!).toList();

  String viewStateValue =
      document.querySelector('input[name=__VIEWSTATE]')?.attributes['value'] ??
          '';

  Map<String, String> formData = {
    "__EVENTTARGET": "ctl00\$ContentPlaceHolder1\$ctl00\$rad_ThuTiet",
    "__EVENTARGUMENT": "",
    "__VIEWSTATE": viewStateValue,
    "__VIEWSTATEGENERATOR": "CA0B0334",
    "ctl00\$ContentPlaceHolder1\$ctl00\$ddlChonNHHK": hocky == 0
        ? listSemester.first
        : listSemester[listSemester.length - hocky],
    "ctl00\$ContentPlaceHolder1\$ctl00\$ddlLoai": "1",
    "ctl00\$ContentPlaceHolder1\$ctl00\$rad_ThuTiet": "rad_ThuTiet",
  };

  var postResponse = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: formData,
  );

  var cookies = postResponse.headers['set-cookie'] ?? '';

  // Call the helper function to get the updated document
  var updatedResponse = await getRequest(cookies, url);
  if (updatedResponse == null) return null;

  document = parse(updatedResponse);
  var title =
      document.getElementById("ctl00_ContentPlaceHolder1_ctl00_lblNote");
  String startDateString =
      title?.text.substring(title.text.length - 11, title.text.length - 1) ??
          '';

  DateTime startDate = DateFormat("dd/MM/yyyy").parse(startDateString);
  DateTime now = DateTime.now();
  // int weeksBetween = now.difference(startDate).inDays ~/ 7;
  // print('Số tuần từ ngày hiện tại đến ngày bắt đầu học kỳ: $weeksBetween');
  // print("startDateString: $startDate");
  var tables = document.getElementsByClassName("body-table");
  List<Subject> subjects = [];

  for (var tb in tables) {
    var tds = tb.getElementsByTagName("td");
    String courseCode = tds[0].text;
    String courseName = tds[1].text;
    String courseGroup = tds[2].text;
    int credits = int.parse(tds[3].text);
    String classCode = tds[4].text;
    String numberOfTuitionCredits = tds[5].text;
    String day = tds[8].text;
    String startPeriod = tds[9].text;
    int numberOfPeriods = int.parse(tds[10].text);
    String room = tds[11].text;
    String week = tds[13].text;
    String periodTime = _getPeriodOfTime(
        tds[13].getElementsByTagName("div").first.attributes["onmouseover"] ??
            " ' ' ");
    subjects.add(Subject(
        courseCode,
        courseName,
        courseGroup,
        credits,
        classCode,
        numberOfTuitionCredits,
        startPeriod,
        numberOfPeriods,
        room,
        week,
        hocky,
        day,
        startDate,
        periodTime));
  }

  return subjects;
}

Future<String?> getRequest(String cookie, String url) async {
  var response = await http.get(
    Uri.parse(url),
    headers: {'Cookie': cookie},
  );

  if (response.statusCode == 200) {
    return response.body;
  }
  return null;
}

String _getPeriodOfTime(String week) {
  //example : ddrivetiptuan('11/11/2024--22/12/2024')
  List<String> arr = week.split("'");
  return arr[1];
}
