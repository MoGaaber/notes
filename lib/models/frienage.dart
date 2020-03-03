class FrienageModel {
  String date;
  InnerModel firstInnerModel, secondInnerModel;
  FrienageModel({this.date, this.firstInnerModel, this.secondInnerModel});
  Map<String, dynamic> toJson() => {
        'Date': this.date,
        'Disc Frien': this.firstInnerModel,
        'Plaqwets': this.secondInnerModel
      };
}

class InnerModel {
  num km;
  bool front, rear;
  InnerModel({this.km, this.front, this.rear});
}
