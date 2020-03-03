class VidangeModel {
  num km, nextOil;
  String date, note;
  Map oil;
  Map air;
  Map fuel;
  Map clim;
  VidangeModel(
      {this.km,
      this.nextOil,
      this.note,
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
        'Clim': this.clim,
        'Note': this.note
      };
}

class VidangeFilterModel {
  bool excited;
  num price;
  VidangeFilterModel({this.excited, this.price});
  Map<String, dynamic> toJson() =>
      {'Price': this.price, 'Excited': this.excited};
}
