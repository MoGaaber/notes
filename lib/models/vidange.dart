class VidangeModel {
  num km, nextOil;
  String date, note;
  VidangeFilterModel oil;
  VidangeFilterModel air;
  VidangeFilterModel fuel;
  VidangeFilterModel clim;
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
        'Next Oil Change': this.nextOil,
        'Date': this.date,
        'Oil / Huile': this.oil.toJson(),
        'Air': this.air.toJson(),
        'Fuel / Carburant': this.fuel.toJson(),
        'Clim': this.clim.toJson(),
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
