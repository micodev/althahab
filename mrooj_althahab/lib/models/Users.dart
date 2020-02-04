class Users {
  int id;
  String name;
  String number;
  String password;
  int balance;
  String error;
  String apitoken;
  Users(
      {this.id,
      this.name,
      this.number,
      this.error,
      this.password,
      this.balance,
      this.apitoken});
  Map<String, dynamic> toDatabaseJson() => {
        'name': name,
        'number': number,
        'password': password,
        'balance': balance,
        'api_token': apitoken
      };

  factory Users.fromDatabaseJson(Map<String, dynamic> json) => Users(
        //Factory method will be used to convert JSON objects that
        //are coming from querying the database and converting
        //it into a Todo object
        id: json["id"],
        name: json["name"],
        number: json["number"],
        password: json["password"],
        balance: json["balance"],
        apitoken: json["api_token"],
      );
}
