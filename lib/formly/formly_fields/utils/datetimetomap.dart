part of formly;

DateTime _fromJsonToDateTime(dynamic field) {
  if (field.runtimeType == String) {
    return DateTime.parse(field);
  }
  if (field is Map) {
    return DateTime.fromMillisecondsSinceEpoch(field['\$date'], isUtc: false);
  }
  return null;
}

Map<String, int> DateTimeToMap(DateTime dt) {
  var r = Map<String, int>();
  r["\$date"] = dt.millisecondsSinceEpoch;
  return r;
}