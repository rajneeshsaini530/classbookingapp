class ClassModel {
  ClassModel({
    this.classId,
    this.className,
    this.classDate,
    this.classTime,
    this.classAvailableSeats,
    this.week,
  });

  int? classId;
  String? className;
  String? classDate;
  String? classTime;
  int? classAvailableSeats;
  int? week;

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        classId: json["class_id"],
        className: json["class_name"],
        classDate: json["class_date"],
        classTime: json["class_time"],
        classAvailableSeats: json["class_available_seats"],
        week: json["week"],
      );

  Map<String, dynamic> toJson() => {
        "class_id": classId,
        "class_name": className,
        "class_date": classDate,
        "class_time": classTime,
        "class_available_seats": classAvailableSeats,
        "week": week,
      };
}
