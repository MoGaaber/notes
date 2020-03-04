class BatterieModel {
  String date, note;
  num km;
  BatterieModel({this.date, this.note, this.km});

  Map<String, dynamic> toJson() => {
        'Date': this.date,
        'KM': this.km,
        'Note': this.note,
      };
}
