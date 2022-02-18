/// Data recieved from a device scan; response from device scan will be a capture event containing decoded data.
class DecodedData {
  int id = 0;
  String name = '';
  List<dynamic> data = [];

  DecodedData(this.id, this.name, this.data);
}
