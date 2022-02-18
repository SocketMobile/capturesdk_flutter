/// Where the event data stems from.
class DataSource {
  int? id;
  String? name;
  int? status;
  int? flags;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['id'] = id;
    pigeonMap['name'] = name;
    pigeonMap['status'] = status;
    pigeonMap['flags'] = flags;
    return pigeonMap;
  }

  static DataSource decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return DataSource()
      ..id = pigeonMap['id'] as int?
      ..name = pigeonMap['name'] as String?
      ..status = pigeonMap['status'] as int?
      ..flags = pigeonMap['flags'] as int?;
  }
}
