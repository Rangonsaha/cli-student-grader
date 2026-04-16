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
        recordScore(students);
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

// Add Student
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

// Record Score Function
void recordScore(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

  // Indexed for loop
  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }

  print("Choose student:");
  var index = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

  if (index < 1 || index > students.length) {
    print("Invalid selection.");
    return;
  }

  var student = students[index - 1];

  print("Subjects: ${availableSubjects.join(", ")}");

  int score;

  // while loop validation
  while (true) {
    print("Enter score (0-100):");
    score = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

    if (score >= 0 && score <= 100) {
      break;
    } else {
      print("Invalid score! Try again.");
    }
  }

  student["scores"].add(score);

  print("Score added successfully!");
}