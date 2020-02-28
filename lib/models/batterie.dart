class BatterieModel {
  String date, note;
  double km;
  BatterieModel({this.date, this.note, this.km});

  Map<String, dynamic> toJson() =>
      {'date': this.date, 'note': this.note, 'km': this.km};
}
