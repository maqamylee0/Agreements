class RateModel {
  String? landlordUid;
  String? nameTenant;
  String? ninTenant;
  String? phoneLandLord;
  String? neighbourliness;
  String? utility;
  String? rent;
  String? maintenamnce;
  String? comments;

  RateModel(this.landlordUid,
      this.nameTenant,
      this.ninTenant,
      this.phoneLandLord,
      this.neighbourliness,
      this.utility,
      this.rent,
      this.maintenamnce,
      this.comments);

  Map<String, dynamic> toMap() {
    return {
      'landlordUid': this.landlordUid,
      'nameTenant': this.nameTenant,
      'ninTenant': this.ninTenant,
      'phoneLandLord': this.phoneLandLord,
      'neighbourliness': this.neighbourliness,
      'utility': this.utility,
      'rent': this.rent,
      'maintenamnce': this.maintenamnce,
      'comments': this.comments,
    };
  }

  // factory RateModel.fromMap(Map<String, dynamic> map) {
  //   return RateModel(
  //     landlordUid: map['landlordUid'] ,
  //     nameTenant: map['nameTenant'] ,
  //     ninTenant: map['ninTenant'],
  //     phoneLandLord: map['phoneLandLord'] ,
  //     neighbourliness: map['neighbourliness'],
  //     utility: map['utility'],
  //     rent: map['rent'] ,
  //     maintenamnce: map['maintenamnce'] ,
  //     comments: map['comments'] ,
  //   );
  // }
}