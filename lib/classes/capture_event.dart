/// Response from the capture library based on user interaction.
/// When you use the scanner to scan a barcode, you will recieve a CaptureEvent of the decoded data.
class CaptureEvent {
  int id;
  int type;
  dynamic value;
  int? handle;
  dynamic result;

  CaptureEvent(this.id, this.type, this.value, [this.handle, this.result]);

  CaptureEvent.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        value = json['value'],
        result = json['result'],
        handle = json['handle'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'value': value,
        'handle': handle,
        'result': result
      };
}
