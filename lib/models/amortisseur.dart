class ArmortisseurModel {
  String date, note;
  num km;
  bool rear, front;

  ArmortisseurModel({this.date, this.note, this.km, this.rear, this.front});
  Map<String, dynamic> toJson() => {
        'Date': this.date,
        'KM': this.km,
        'Rear / AV': this.rear,
        'Front / AV': this.front,
        'Note': this.note,
      };
}
