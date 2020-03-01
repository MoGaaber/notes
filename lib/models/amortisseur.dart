class ArmortisseurModel {
  String date, note;
  double km;
  bool rear, front;

  ArmortisseurModel({this.date, this.note, this.km, this.rear, this.front});
  Map<String, dynamic> toJson() => {
        'Rear / AV': this.rear,
        'Front / AV': this.front,
        'Date': this.date,
        'Note': this.note,
        'KM': this.km
      };
}
