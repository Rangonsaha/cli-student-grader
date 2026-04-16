import 'dart:io';

// const
const String appTitle = "Student Grader v1.0";

// final
final Set<String> availableSubjects = {
  "Math",
  "English",
  "Science",
  "ICT"
};

void main() {
  var students = <Map<String, dynamic>>[];
  var isRunning = true;

  do {
    print("""
===== $appTitle =====

1. Add Student
2. Record Score
3. Add Bonus Points
4. Add Comment
5. View All Students
6. View Report Card
7. Class Summary
8. Exit

Choose an option:
""");

    var choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        addStudent(students);
        break;
      case "2":
        print("Record Score selected");
        break;
      case "3":
        print("Add Bonus selected");
        break;
      case "4":
        print("Add Comment selected");
        break;
      case "5":
        print("View All Students selected");
        break;
      case "6":
        print("View Report Card selected");
        break;
      case "7":
        print("Class Summary selected");
        break;
      case "8":
        isRunning = false;
        print("Exiting app...");
        break;
      default:
        print("Invalid option!");
    }
  } while (isRunning);
}

// Add Student Function
void addStudent(List<Map<String, dynamic>> students) {
  print("Enter student name:");
  var name = stdin.readLineSync();

  var student = {
    "name": name,
    "scores": <int>[],
    "subjects": {...availableSubjects},
    "bonus": null,
    "comment": null
  };

  students.add(student);

  print("Student $name added successfully!");
}