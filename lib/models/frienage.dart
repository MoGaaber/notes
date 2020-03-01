class FrienageModel {
  String date, note;
  double km, km2;
  bool rear, front;
  bool rear2, front2;

  FrienageModel(
      {this.date,
      this.note,
      this.km,
      this.km2,
      this.rear,
      this.front,
      this.front2,
      this.rear2});
  Map<String, dynamic> toJson() => {
        'Rear': this.rear,
        'Front': this.front,
        'Rear2': this.rear2,
        'Front2': this.front2,
        'Date': this.date,
        'Note': this.note,
        'KM': this.km,
        'KM2': this.km2
      };
}
