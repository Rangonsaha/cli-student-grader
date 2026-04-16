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
        addBonus(students);
        break;
      case "4":
        addComment(students);
        break;
      case "5":
        viewAllStudents(students);
        break;
      case "6":
        viewReportCard(students);
        break;
      case "7":
        classSummary(students);
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

// Record Score
void recordScore(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

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

  int score;

  while (true) {
    print("Enter score (0-100):");
    score = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

    if (score >= 0 && score <= 100) break;
    print("Invalid score! Try again.");
  }

  student["scores"].add(score);
  print("Score added successfully!");
}

// Add Bonus
void addBonus(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

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

  print("Enter bonus (1-10):");
  var bonus = int.tryParse(stdin.readLineSync() ?? "") ?? 0;

  if (student["bonus"] == null) {
    student["bonus"] ??= bonus;
    print("Bonus added!");
  } else {
    print("Bonus already assigned!");
  }
}

// Add Comment
void addComment(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }

  print("Choose student:");
  var index = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

  if (index < 1 || index > students.length) {
    print("Invalid selection.");
    return;
  }

  print("Enter comment:");
  var comment = stdin.readLineSync();

  students[index - 1]["comment"] = comment;
  print("Comment added!");
}

// View All Students
void viewAllStudents(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students found.");
    return;
  }

  for (var student in students) {
    var tags = [
      student["name"],
      "${student["scores"].length} scores",
      if (student["bonus"] != null) " Has Bonus"
    ];

    var comment =
        student["comment"]?.toUpperCase() ?? "No comment";

    print("${tags.join(" | ")} | $comment");
  }
}

// Calculate Average
double calculateAverage(Map<String, dynamic> student) {
  var scores = student["scores"] as List<int>;

  if (scores.isEmpty) return 0;

  int sum = 0;

  for (var s in scores) {
    sum += s;
  }

  double avg = sum / scores.length;

  avg += (student["bonus"] ?? 0);

  if (avg > 100) avg = 100;

  return avg;
}

// Report Card
void viewReportCard(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

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

  var avg = calculateAverage(student);

  String grade;

  if (avg >= 90) {
    grade = "A";
  } else if (avg >= 80) {
    grade = "B";
  } else if (avg >= 70) {
    grade = "C";
  } else if (avg >= 60) {
    grade = "D";
  } else {
    grade = "F";
  }

  var bonus = student["bonus"] ?? 0;
  var comment =
      student["comment"]?.toUpperCase() ?? "No comment provided";

  print("""
┌────────────────────────────────────────┐
│             REPORT CARD                │
├────────────────────────────────────────┤
│ Name    : ${student["name"]}           ┤
│ Scores  : ${student["scores"]}         ┤
│ Bonus   : +$bonus                      ┤
├                                        ┤
│ Average : ${avg.toStringAsFixed(2)}    ┤
│ Grade   : $grade                       ┤
├                                        ┤
│ Comment : $comment                     ┤
└────────────────────────────────────────┘
""");

  String feedback = switch (grade) {
    "A" => "Outstanding performance!",
    "B" => "Good work, keep it up!",
    "C" => "Satisfactory. Room to improve.",
    "D" => "Needs improvement.",
    "F" => "Failing. Please seek help.",
    _ => "Unknown grade."
  };

  print("Feedback: $feedback");
}

// Class Summary
void classSummary(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

  double total = 0;
  double highest = 0;
  double lowest = 100;
  int count = 0;

  Set<String> grades = {};

  for (var s in students) {
    var avg = calculateAverage(s);

    // logical operator &&
    if (s["scores"].isNotEmpty && avg >= 0) {
      total += avg;
      count++;

      if (avg > highest) highest = avg;
      if (avg < lowest) lowest = avg;

      grades.add(getGrade(avg));
    }
  }

  var classAvg = count == 0 ? 0 : total / count;

  // collection for
  var summaryLines = [
    for (var s in students)
      "${s["name"]}: ${calculateAverage(s).toStringAsFixed(2)}"
  ];

  print("""
===== CLASS SUMMARY =====
Total Students: ${students.length}
Class Average: ${classAvg.toStringAsFixed(2)}
Highest: ${highest.toStringAsFixed(2)}
Lowest: ${lowest.toStringAsFixed(2)}
Grades Present: $grades

Student Averages:
${summaryLines.join("\n")}
""");
}

String getGrade(double avg) {
  if (avg >= 90) return "A";
  if (avg >= 80) return "B";
  if (avg >= 70) return "C";
  if (avg >= 60) return "D";
  return "F";
}