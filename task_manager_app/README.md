# 📝 Task Manager App

A simple yet efficient Flutter application to manage daily tasks, built with MVVM architecture and local SQLite database support. The app allows users to add, view, complete, and delete tasks — all wrapped in a clean, theme-switchable UI.

---

## 🚀 Features

* ✅ Add, view, complete, and delete tasks
* 💾 Local data persistence using SQLite
* 🎨 Light and dark theme support
* 📱 Clean and consistent UI with reusable components
* 🧠 MVVM architecture with Provider for state management

---

## 🖼️ Screenshots

![image](https://github.com/user-attachments/assets/e6f464e1-33a3-41a7-93ff-7eb088353b4c)

---

## 🧱 Project Structure

```
lib/
├── core/
│   ├── db/                 # SQLite helper (DataBaseHelper)
│   ├── theme/              # AppTheme, AppColors
│   └── provider/           # ThemeProvider
├── utils/                  # NavigationUtils, other helpers
├── view/                   # UI views (HomeView, AddTaskView)
├── view_model/             # ViewModels for task operations
├── main.dart               # Entry point
└── app.dart                # Root widget with provider setup
```

---

## 📦 Dependencies

Make sure your `pubspec.yaml` includes:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  sqflite: ^2.3.0
  path: ^1.8.3
  path_provider: ^2.1.2
```

Run `flutter pub get` to install all dependencies.

---

## ⚙️ Getting Started

1. **Clone the repository**

```bash
git clone https://github.com/your-username/task-manager-app.git
cd task-manager-app
```

2. **Install packages**

```bash
flutter pub get
```

3. **Run the app**

```bash
flutter run
```

---

## 🧠 ViewModels Overview

* `GetTaskViewModel` – Fetches and manages task list
* `AddTaskViewModel` – Handles task creation logic
* `DeleteTaskViewModel` – Manages task deletion
* `ToggleTaskViewModel` – (optional) For toggling completion status

---

## 💡 Architecture

This project follows **MVVM** (Model-View-ViewModel) structure for scalability and testability.
It also separates UI logic, business logic, and database operations for clean code practices.

---

## 🌓 Theme Support

Users can switch between light and dark themes using the `ThemeProvider`. Colors are defined centrally via `AppColors`.

---

## 📇 Database

SQLite is used for storing tasks locally.
Implemented using the `sqflite` package via `DataBaseHelper`.



