class Treatment_Record {

  int _id;
  String _title;
  String _result;
  String _date;
  int _stops;

  Treatment_Record(this._title, this._date, this._result, this._stops);

  Treatment_Record.withId(this._id, this._title, this._date, this._stops, this._result);

  int get id => _id;

  String get title => _title;

  String get result => _result;

  int get stops => _stops;

  String get date => _date;

  set title(String newTitle) {
    this._title = newTitle;
  }

  set result(String newresult) {
    this._result = newresult;
  }

  set stops(int newStops) {
    this._stops = newStops;
  }

  set date(String newDate) {
    this._date = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['result'] = _result;
    map['stops'] = _stops;
    map['date'] = _date;

    return map;
  }

  Treatment_Record.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._result = map['result'];
    this._stops = map['stops'];
    this._date = map['date'];
  }
}
