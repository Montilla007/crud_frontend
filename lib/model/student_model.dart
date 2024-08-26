// lib/model/student_model.dart
class Student {
  String? id; // Add an id field if your backend requires it
  String firstName;
  String lastName;
  String course;
  String year;
  bool enrolled;

  Student({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  // Convert Student to a map for sending to backend
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'course': course,
      'year': year,
      'enrolled': enrolled,
    };
  }

  // Create a Student from a map
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['_id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      course: map['course'],
      year: map['year'],
      enrolled: map['enrolled'],
    );
  }
}
