class DepartmentModel {
  final int id;
  final String title;

  DepartmentModel({
    required this.id,
    required this.title,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> data) {
    return DepartmentModel(
      id: data['id'] as int? ?? 0, // Provide a default value for 'id'
      title: data['title'] as String? ?? '', // Provide a default value for 'title'
    );
  }
}
