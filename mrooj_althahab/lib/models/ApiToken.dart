class ApiToken {
  String apitoken;
  String error;
  ApiToken({this.apitoken, this.error});
  Map<String, dynamic> toDatabaseJson() => {'api_token': apitoken};

  factory ApiToken.fromDatabaseJson(Map<String, dynamic> json) =>
      ApiToken(apitoken: json["api_token"]);
}
