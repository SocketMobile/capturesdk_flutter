/// What version of capture is being used.
class CaptureVersion {

  CaptureVersion(
      [this.major,
      this.middle,
      this.minor,
      this.build,
      this.year,
      this.month,
      this.day,
      this.hour,
      this.minute]);
  int? major;
  int? middle;
  int? minor;
  int? build;
  int? year;
  int? month;
  int? day;
  int? hour;
  int? minute;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['major'] = major;
    pigeonMap['middle'] = middle;
    pigeonMap['minor'] = minor;
    pigeonMap['build'] = build;
    pigeonMap['year'] = year;
    pigeonMap['month'] = month;
    pigeonMap['day'] = day;
    pigeonMap['hour'] = hour;
    pigeonMap['minute'] = minute;
    return pigeonMap;
  }

  static CaptureVersion decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return CaptureVersion()
      ..major = pigeonMap['major'] as int?
      ..middle = pigeonMap['middle'] as int?
      ..minor = pigeonMap['minor'] as int?
      ..build = pigeonMap['build'] as int?
      ..year = pigeonMap['year'] as int?
      ..month = pigeonMap['month'] as int?
      ..day = pigeonMap['day'] as int?
      ..hour = pigeonMap['hour'] as int?
      ..minute = pigeonMap['minute'] as int?;
  }
}
