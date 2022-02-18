/// Basic properties for a paired or stored device.
class DeviceInfo {
  String name;
  String guid;
  int type;

  DeviceInfo(this.name, this.guid, this.type);

  DeviceInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        guid = json['guid'],
        type = json['type'];

  Map<String, dynamic> toJson() => {'name': name, 'guid': guid, 'type': type};
}
