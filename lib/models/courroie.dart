class CourroieModel {
  double km, nextKm;
  String note, date;

  CourroieModel({this.km, this.nextKm, this.note, this.date});

  Map<String, dynamic> toJson() =>
      {'km': km, 'nextKm': this.nextKm, 'note': this.note, 'date': this.date};
}
