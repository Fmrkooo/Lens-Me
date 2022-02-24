class CustomerModel{
  String? name;
  String? email;
  String? phone;
  String? password;
  String? customerId;
  List<String>? favorites;
  bool? isPhotographer;
  Map<String,dynamic>? rate;

  CustomerModel({
    this.email,
    this.name,
    this.phone,
    this.password,
    this.customerId,
    this.favorites,
    this.isPhotographer,
    this.rate,
  });

  CustomerModel.fromJson(Map<String,dynamic>json)
  {
    email=json['email'];
    name=json['name'];
    phone=json['phone'];
    password=json['password'];
    customerId=json['customerId'];
    favorites = (json['favorites'] as List<dynamic>).map((e) => e.toString()).toList();
    isPhotographer=json['isPhotographer'];
    rate=json['rate'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'customerId':customerId,
      'password':password,
      'favorites':favorites,
      'isPhotographer':isPhotographer,
      'rate':rate,
    };
  }

  Map<String,dynamic> mapTypeUser(){
    return {
      'email':email,
      'isPhotographer':isPhotographer,

    };
  }

}