class TenantModel {
  String? landlordUid;
  String? name;
  String? nin;
  String? phone;
  String? email;
  String? nextOfKin;
  String? emergencyPhone;
  String? previousLandLordPhone;
  String? currentEmployerPhone;


  TenantModel({this.landlordUid,this.name,this.nin,this.phone, this.email, this.nextOfKin,this.emergencyPhone,this.previousLandLordPhone,this.currentEmployerPhone});

  // receiving data from server
  factory TenantModel.fromMap(map) {
    return TenantModel(
      landlordUid: map['landlordUid'], nin: map['nin'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      nextOfKin: map['nextOfKin'],
      emergencyPhone: map['emergencyPhone'],
      previousLandLordPhone: map['previousLandLordPhone'],
      currentEmployerPhone: map['currentEmployerPhone']

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'landlordUid': landlordUid,
      'name': name,
      'nin': nin,
      'phone': phone,
      'email': email,
      'nextOfKin': nextOfKin,
      'emergencyPhone':emergencyPhone,
      'previousLandLordPhone':previousLandLordPhone,
      'currentEmployerPhone':currentEmployerPhone

    };
  }
}