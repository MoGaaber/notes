class FrienageModel {
  String date;
  InnerModel firstInnerModel, secondInnerModel;
  FrienageModel({this.date, this.firstInnerModel, this.secondInnerModel});
  Map<String, dynamic> toJson() => {
        'Date': this.date,
        'Disque de frein /Brake Disc': this.firstInnerModel.toJson(),
        'Plaquette de frien /Brake Pad': this.secondInnerModel.toJson()
      };
}

class InnerModel {
  num km;
  bool front, rear;
  InnerModel({this.km, this.front, this.rear});
  Map<String, dynamic> toJson() =>
      {'KM': this.km, 'Front / AV': this.front, 'Rear / AR': this.rear};
}
