// ignore_for_file: file_names
/// Used in requests as well as storing device or property details.
class Params {
  int? handle = 0;
  String? guid;
  dynamic property;

  Params(this.handle, {this.guid, this.property});

  Params.fromJson(Map<String, dynamic> json)
      : handle = json['handle'],
        guid = json['guid'],
        property = json['property'];

  Map<String, dynamic> toJson() =>
      {'handle': handle, 'guid': guid, 'property': property};
}
