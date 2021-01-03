class Customer {
  String firstName;
  String lastName;
  String phoneCode;
  String mobileNo;
  String password;
  String confirmPassword;
  bool subscribeNewsLetter;
  String partnerName;
  int stateId;
  String city;
  String street;
  String latitude;
  String longitude;
  int code;

  Customer();

  Customer.fromJSON(Map<String, dynamic> jsonMap) {
    firstName = jsonMap['firstName'];
    lastName = jsonMap['lastName'];
    phoneCode = jsonMap['phoneCode'];
    mobileNo = jsonMap['mobileNo'];
    password = jsonMap['password'];
    subscribeNewsLetter = jsonMap['subscribeNewsLetter'];
    partnerName = jsonMap['partnerName'];
    stateId = jsonMap['stateId'];
    city = jsonMap['city'];
    street = jsonMap['street'];
    latitude = jsonMap['latitude'];
    longitude = jsonMap['longitude'];
    code = jsonMap['code'];
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['phoneCode'] = phoneCode;
    map['mobileNo'] = mobileNo;
    map['password'] = password;
    map['subscribeNewsLetter'] = subscribeNewsLetter;
    map['partnerName'] = partnerName;
    map['stateId'] = stateId;
    map['city'] = city;
    map['street'] = street;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['code'] = code;
    return map;
  }
}
