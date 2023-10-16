// ignore_for_file: unnecessary_this

//Wrappper for Json rpc instances used in Http Transport.
class JsonRpc {
  JsonRpc([this.id]);
  String jsonrpc = '2.0';
  int? id;
}
