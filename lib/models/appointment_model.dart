class AppointmentModel {
  String? customerName;
  String? photographerName;
  String? customerPhone;
  String? photographerPhone;
  String? city;
  String? location;
  String? shootingType;
  String? appointmentTime;
  String? price;
  String? offer;
  String? photographerId;
  String? customerId;

  AppointmentModel({
    this.customerName,
    this.photographerName,
    this.customerPhone,
    this.photographerPhone,
    this.city,
    this.location,
    this.shootingType,
    this.appointmentTime,
    this.price,
    this.offer,
    this.photographerId,
    this.customerId
  });

  AppointmentModel.fromJson(Map<String, dynamic>json)
  {
    customerName = json['customerName'];
    photographerName = json['photographerName'];
    customerPhone = json['customerPhone'];
    photographerPhone = json['photographerPhone'];
    city = json['city'];
    location = json['location'];
    shootingType = json['shootingType'];
    appointmentTime = json['appointmentTime'];
    price = json['price'];
    offer = json['offer'];
    photographerId = json['photographerId'];
    customerId = json['customerId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'photographerName': photographerName,
      'customerPhone': customerPhone,
      'photographerPhone': photographerPhone,
      'city': city,
      'location': location,
      'shootingType': shootingType,
      'appointmentTime': appointmentTime,
      'price': price,
      'offer': offer,
      'photographerId': photographerId,
      'customerId': customerId,
    };
  }
}