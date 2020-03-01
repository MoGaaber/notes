class VidangeModel {
  double km, nextOil;
  String date;
  VidangeFilterModel oil;
  VidangeFilterModel air;
  VidangeFilterModel fuel;
  VidangeFilterModel clim;
  VidangeModel(
      {this.km,
      this.nextOil,
      this.date,
      this.oil,
      this.air,
      this.clim,
      this.fuel});
  Map<String, dynamic> toJson() => {
        'KM': km,
        'Next Oil': this.nextOil,
        'Date': this.date,
        'Oil': this.oil,
        'Air': this.air,
        'Fuel': this.fuel,
        'Clim': this.clim
      };
}

class VidangeFilterModel {
  bool yesOrNo;
  double price;
  VidangeFilterModel({this.yesOrNo, this.price});
  Map<String, dynamic> toJson() => {'yesOrNo': yesOrNo, 'price': price};
}
