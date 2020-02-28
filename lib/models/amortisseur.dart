class ArmortisseurModel {
  String date, note;
  double km;
  bool rear, front;

  ArmortisseurModel({this.date, this.note, this.km, this.rear, this.front});
  Map<String, dynamic> toJson() => {
        'rear': this.rear,
        'front': this.front,
        'date': this.date,
        'note': this.note,
        'km': this.km
      };
}
