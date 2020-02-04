class Orders {
  int id;
  String customNumber;
  String checkId;
  int cost;
  String date;
  int condition; //0=nothing  1=deliver  2=back
  int userId;
  String error;
  Orders(
      {this.id,
      this.customNumber,
      this.cost,
      this.date,
      this.error,
      this.condition,
      this.userId,
      this.checkId});
  Map<String, dynamic> toDatabaseJson() => {
        'customer_number': customNumber,
        'cost': cost,
        'checkId': checkId,
        'created_at': date,
        'condition': condition,
        'user_id': userId
      };

  factory Orders.fromDatabaseJson(Map<String, dynamic> json) => Orders(
        //Factory method will be used to convert JSON objects that
        //are coming from querying the database and converting
        //it into a Todo object
        id: json["id"],
        customNumber: json["customer_number"],
        cost: json["cost"],
        checkId: json["checkId"],
        date: json["created_at"],
        condition: json["condition"],
        userId: json["user_id"],
      );
}
