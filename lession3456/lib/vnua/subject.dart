class Subject {
  String _courseCode; // Mã học phần
  String _courseName; // Tên học phần
  String _courseGroup; // Nhóm học phần
  int _credits; // Số tín chỉ
  String _classCode; // Mã lớp
  String _numberOfTuitionCredits; // Số tín chỉ học phí
  String _startPeriod; // Tiết bắt đầu
  int _numberOfPeriods; // Số tiết
  String _room; // Phòng học
  String _week; // tuần
  int _semester;
  String _dayOfWeek;
  DateTime _startDate;
  String _periodOfTime;

  Subject(
      this._courseCode,
      this._courseName,
      this._courseGroup,
      this._credits,
      this._classCode,
      this._numberOfTuitionCredits,
      this._startPeriod,
      this._numberOfPeriods,
      this._room,
      this._week,
      this._semester,
      this._dayOfWeek,
      this._startDate,
      this._periodOfTime);

  String get courseCode => _courseCode;

  set courseCode(String value) {
    _courseCode = value;
  }

  @override
  String toString() {
    return 'Subject{_courseCode: $_courseCode, _courseName: $_courseName, _courseGroup: $_courseGroup, _credits: $_credits, _classCode: $_classCode, _numberOfTuitionCredits: $_numberOfTuitionCredits, _startPeriod: $_startPeriod, _numberOfPeriods: $_numberOfPeriods, _room: $_room, _week: $_week, _semester: $_semester, _dayOfWeek: $_dayOfWeek, _startDate: $_startDate ,__periodOfTime :$_periodOfTime}';
  }

  String get courseName => _courseName;

  set courseName(String value) {
    _courseName = value;
  }

  String get courseGroup => _courseGroup;

  set courseGroup(String value) {
    _courseGroup = value;
  }

  int get credits => _credits;

  set credits(int value) {
    _credits = value;
  }

  String get classCode => _classCode;

  set classCode(String value) {
    _classCode = value;
  }

  String get numberOfTuitionCredits => _numberOfTuitionCredits;

  set numberOfTuitionCredits(String value) {
    _numberOfTuitionCredits = value;
  }

  String get startPeriod => _startPeriod;

  set startPeriod(String value) {
    _startPeriod = value;
  }

  int get numberOfPeriods => _numberOfPeriods;

  set numberOfPeriods(int value) {
    _numberOfPeriods = value;
  }

  String get room => _room;

  set room(String value) {
    _room = value;
  }

  String get week => _week;

  set week(String value) {
    _week = value;
  }

  int get semester => _semester;

  set semester(int value) {
    _semester = value;
  }

  String get dayOfWeek => _dayOfWeek;

  set dayOfWeek(String value) {
    _dayOfWeek = value;
  }

  DateTime get startDate => _startDate;

  set startDate(DateTime value) {
    _startDate = value;
  }

  String get periodOfTime => _periodOfTime;

  set periodOfTime(String value) {
    _periodOfTime = value;
  }
}
