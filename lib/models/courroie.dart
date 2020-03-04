class CourroieModel {
  num km, nextKm;
  String note, date;

  CourroieModel({this.km, this.nextKm, this.note, this.date});

  Map<String, dynamic> toJson() => {
        'Date': this.date,
        'KM': km,
        'Next Km': this.nextKm,
        'Note': this.note,
      };
}
