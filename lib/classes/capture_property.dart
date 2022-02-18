/// Class for properties recieved/submitted in requests to Capture library.
/// Capture properties can represent a device name, device type, monitor mode, etc.

class CaptureProperty {
  int? id;
  int? type;
  dynamic value;

  CaptureProperty(this.id, this.type, [this.value]);

  CaptureProperty.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        value = json['value'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'value': value,
      };
}
