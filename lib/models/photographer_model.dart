class PhotographerModel{
  String? name;
  String? email;
  String? phone;
  int? initialPrice;
  String? experienceYears;
  int? like;
  int? dislike;
  String? profilePicture='https://img.discogs.com/OAwSHqdnbBPHzyCULjhIk1_O7f8=/300x300/filters:strip_icc():format(jpeg):quality(40)/discogs-avatars/U-6234876-1552313744.jpeg.jpg';
  List<String>? gallery = [];
  List<String>? locations = [];
  List<String>? shootingTypes = [];
  List<String>? socialLinks = [];
  List<String>? freeTimes=[];
  String? offer;
  String? password;
  String? photographerId;
  bool? isPhotographer;

  PhotographerModel({
    this.email,
    this.name,
    this.phone,
    this.initialPrice,
    this.experienceYears,
    this.like,
    this.dislike,
    this.profilePicture,
    this.gallery,
    this.locations,
    this.shootingTypes,
    this.socialLinks,
    this.freeTimes,
    this.offer,
    this.password,
    this.photographerId,
    this.isPhotographer,
    //this.freeTimes
  });
  PhotographerModel.fromJson(Map<String,dynamic>json)
  {
    email=json['email']??'';
    name=json['name']??'';
    phone=json['phone']??'';
    initialPrice=json['initialPrice']??'';
    experienceYears=json['experienceYears']??'';
    like=json['like']??'';
    dislike=json['dislike']??'';
    profilePicture=json['profilePicture']??'';
    gallery = (json['gallery'] as List<dynamic>).map((e) => e.toString()).toList();
    locations = (json['locations'] as List<dynamic>).map((e) => e.toString()).toList();
    // json['location'].forEach((element)
    // {
    //   locations!.add(element);
    // });
    shootingTypes = (json['shootingTypes'] as List<dynamic>).map((e) => e.toString()).toList();
    // json['shootingTypes'].forEach((element)
    // {
    //   shootingTypes!.add(element);
    // });
    socialLinks = (json['socialLinks'] as List<dynamic>).map((e) => e.toString()).toList();
    freeTimes = (json['freeTimes'] as List<dynamic>).map((e) => e.toString()).toList();
    offer=json['offer']??'';
    password=json['password']??'';
    photographerId=json['photographerId']??'';
    isPhotographer=json['isPhotographer']??'';
    //freeTimes=json['freeTimes']??'';
  }


  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'initialPrice':initialPrice,
      'experienceYears':experienceYears,
      'like':like,
      'dislike':dislike,
      'gallery':gallery,
      'profilePicture':profilePicture,
      'locations':locations,
      'freeTimes':freeTimes,
      'shootingTypes':shootingTypes,
      'socialLinks':socialLinks,
      'offer':offer,
      'photographerId':photographerId,
      'password':password,
      'isPhotographer':isPhotographer,
      //'freeTimes':freeTimes
    };
  }

  Map<String,dynamic> mapTypeUser(){
    return {
      'email':email,
      'isPhotographer':isPhotographer,
    };
  }

  Map<String,dynamic> favorites(){
    return {
      'favorites':favorites,
    };
  }

}