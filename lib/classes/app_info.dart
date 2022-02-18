/// This is the app information used to access the API.
/// These credentials are generated when you register your app on the Socket Mobile website.
class AppInfo {
  String appIdAndroid;
  String appIdIos;
  String appKeyAndroid;
  String appKeyIos;
  String developerId;

  AppInfo(this.appIdAndroid, this.appKeyAndroid, this.appIdIos, this.appKeyIos,
      this.developerId);

  AppInfo.fromJson(Map<String, dynamic> json)
      : appIdAndroid = json['appId'],
        appKeyAndroid = json['appKey'],
        appIdIos = '',
        appKeyIos = '',
        developerId = json['developerId'];

  Map<String, dynamic> toJson() => {
        'appId': appIdAndroid,
        'appKey': appKeyAndroid,
        'developerId': developerId,
      };
}
