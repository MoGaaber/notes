class CourroieModel {
  num km, nextKm;
  String note, date;

  CourroieModel({this.km, this.nextKm, this.note, this.date});

  Map<String, dynamic> toJson() =>
      {'KM': km, 'Next Km': this.nextKm, 'Note': this.note, 'Date': this.date};
}
