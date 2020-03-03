class FrienageModel {
  String date;
  InnerModel firstInnerModel, secondInnerModel;
  FrienageModel({this.date, this.firstInnerModel, this.secondInnerModel});
  Map<String, dynamic> toJson() => {
        'Date': this.date,
        'Disc Frien': this.firstInnerModel.toJson(),
        'Plaqwets': this.secondInnerModel.toJson()
      };
}

class InnerModel {
  num km;
  bool front, rear;
  InnerModel({this.km, this.front, this.rear});
  Map<String, dynamic> toJson() =>
      {'KM': this.km, 'Front / AV': this.front, 'Rear / AV': this.rear};
}
