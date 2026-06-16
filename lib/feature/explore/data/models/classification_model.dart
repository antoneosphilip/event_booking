class ClassificationModel {
  final String id;
  final String name;

  ClassificationModel({required this.id, required this.name});

  factory ClassificationModel.fromJson(Map<String, dynamic> json) {
    final dataObj = json['type'] ?? json['segment'];
    return ClassificationModel(
      id: dataObj?['id'] ?? '',
      name: dataObj?['name'] ?? '',
    );
  }
}
