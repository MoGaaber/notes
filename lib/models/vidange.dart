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
        'km': km,
        'nextOil': this.nextOil,
        'date': this.date,
        'oil': this.oil,
        'air': this.air,
        'fuel': this.fuel,
        'clim': this.clim
      };
}

class VidangeFilterModel {
  bool yesOrNo;
  double price;
  VidangeFilterModel({this.yesOrNo, this.price});
  Map<String, dynamic> toJson() => {'yesOrNo': yesOrNo, 'price': price};
}
