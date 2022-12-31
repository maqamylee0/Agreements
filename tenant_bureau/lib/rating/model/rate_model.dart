class RateModel {
  String? landlordUid;
  String? nameTenant;
  String? ninTenant;
  String? emailLandLord;
  int? neighbourliness;
  int? utility;
  int? rent;
  int? maintenamnce;
  int? condition;
  String? comments;

  RateModel({this.landlordUid,
      this.nameTenant,
      this.ninTenant,
      this.emailLandLord,
      this.neighbourliness,
      this.utility,
      this.rent,
      this.maintenamnce,
     this.condition,
      this.comments});

  Map<String, dynamic> toMap() {
    return {
      'landlordUid': this.landlordUid,
      'nameTenant': this.nameTenant,
      'ninTenant': this.ninTenant,
      'emailLandLord': this.emailLandLord,
      'neighbourliness': this.neighbourliness,
      'utility': this.utility,
      'rent': this.rent,
      'maintenamnce': this.maintenamnce,
      'condition': this.condition,
      'comments': this.comments,
    };
  }

  factory RateModel.fromJson(Map<String, dynamic> map) {
    return RateModel(
      landlordUid: map['landlordUid'] ,
      nameTenant: map['nameTenant'] ,
      ninTenant: map['ninTenant'],
      emailLandLord: map['emailLandLord'] ,
      neighbourliness: map['neighbourliness'],
      utility: map['utility'],
      rent: map['rent'] ,
      maintenamnce: map['maintenamnce'] ,
      condition: map['condition'],
      comments: map['comments'] ,
    );
  }
}