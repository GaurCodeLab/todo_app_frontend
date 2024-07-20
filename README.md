#Todo App Frontend

This is the frontend of a Todo App built with Flutter. The backend is powered by Django, and this application communicates with the Django API to manage todos.

#Features

List all todos
Add a new todo
Edit an existing todo
Delete a todo
Mark a todo as completed


#Getting Started

These instructions will help you get a copy of the project up and running on your local machine for development and testing purposes.

#Prerequisites

Flutter SDK
Dart
Visual Studio Code (Optional, but recommended)
A running instance of the Django backend API

#Installation
Clone the repository:
bash
Copy code
git clone https://github.com/your-username/todo-app-frontend.git
cd todo-app-frontend
Install dependencies:
bash
Copy code
flutter pub get
Run the app:
bash
Copy code
flutter run -d chrome
#Configuration
Ensure that your backend Django API is running and accessible. The default base URL for the API is set to http://localhost:8000/api. If your backend is running on a different URL, you need to update the ApiService class in lib/services/api_service.dart.

dart
Copy code
class ApiService {
  final String baseUrl = "http://localhost:8000/api";  // Update with your Django API URL
  //...
}
#Project Structure
css
Copy code
lib
├── main.dart
├── models
│   └── todo.dart
├── screens
│   ├── add_todo_screen.dart
│   ├── edit_todo_screen.dart
│   └── todo_list_screen.dart
└── services
    └── api_service.dart
    
main.dart: The entry point of the application.
models/todo.dart: The Todo model.
screens/add_todo_screen.dart: Screen for adding a new todo.
screens/edit_todo_screen.dart: Screen for editing an existing todo.
screens/todo_list_screen.dart: Main screen that lists all todos.
services/api_service.dart: Contains methods for communicating with the backend API.

#Usage
Adding a Todo
Click on the floating action button (+) on the main screen.
Fill in the title and description.
Click on "Add Task".
Editing a Todo
Click on a todo item or the edit icon next to it.
Update the title and description.
Click on "Update Task".
Deleting a Todo
Click on the delete icon next to a todo item in the main list.
Alternatively, click on the delete icon in the app bar when editing a todo.
Marking a Todo as Completed
Check the checkbox next to the todo item in the main list.

#Built With
Flutter - The framework used
Dart - Programming language
Django - Backend framework (for the API)

#Contributing
Fork the repository
Create your feature branch (git checkout -b feature/AmazingFeature)
Commit your changes (git commit -m 'Add some AmazingFeature')
Push to the branch (git push origin feature/AmazingFeature)
Open a pull request



#Acknowledgements
Flutter documentation
Django documentation
