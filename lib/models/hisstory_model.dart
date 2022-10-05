class HistoryModel{
  String? userId;
  String? startTime;
  String? endTime;
  String? name;
  String? date;
  HistoryModel({this.userId, this.startTime, this.endTime, this.name, this.date});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    startTime = json['startTime'];
    name = json['name'];
    endTime = json['endTime'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['date'] = this.date;
    return data;
  }
}

// class History{
//   String? startTime;
//   String? endTime;
//   History({this.startTime, this.endTime});
// }