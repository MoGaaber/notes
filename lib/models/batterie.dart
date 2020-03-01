class BatterieModel {
  String date, note;
  double km;
  BatterieModel({this.date, this.note, this.km});

  Map<String, dynamic> toJson() =>
      {'Date': this.date, 'Note': this.note, 'KM': this.km};
}
