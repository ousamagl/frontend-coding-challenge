# Absence Manager

A full-stack application for managing employee absences. Built with Flutter and FastAPI.

👉 **[Watch the Demo](https://drive.google.com/file/d/1GL8ut_fExk1XxhpiZsVaKShKJrAuIlH3/view?usp=sharing)**

---

## Project Structure

- `sickness_manager/` – Flutter app
- `api/` – FastAPI backend (deployed to Heroku)

## Backend (FastAPI)

This project includes a lightweight REST API built using **Python** and **FastAPI**, deployed on **Heroku**. It powers the mobile app by providing user authentication and absence-related data.

API documentation is available here:  
[https://absence-manager-api-6c43055a2bde.herokuapp.com/docs](https://absence-manager-api-6c43055a2bde.herokuapp.com/docs)

### Overview

The API provides four endpoints:

| Method | Endpoint          | Description                                 |
|--------|-------------------|---------------------------------------------|
| POST   | `/login`          | Authenticates the user and returns a token  |
| GET    | `/members`        | Returns a list of team members              |
| GET    | `/absences`       | Returns a paginated list of absences        |
| GET    | `/total-absences` | Returns the total number of absences        |

### Authentication

- The `/login` endpoint returns a **JWT access token**.
- This token must be included in the `Authorization` header (`Bearer <token>`) for all other endpoints.

### Design Decisions

- The API reads from **JSON files** instead of using a database.
- This approach was chosen to simplify setup and avoid infrastructure overhead during the challenge.
- Data is structured in a way that simulates realistic usage (filtering, pagination, etc).

### Filtering Absences

The `/absences` endpoint supports the following filters:

- `user_id`: Member ID
- `crew_id`: Crew ID
- `type`: `"vacation"` or `"sick leave"`
- `status`: `"requested"`, `"rejected"`, `"confirmed"`
- `start_date`, `end_date`: Format `YYYY-MM-DD`

Filters can be combined, and pagination is supported with:

- `skip`: Offset for pagination
- `limit`: Maximum number of results

#### Date Filtering Logic

- If only `start_date` or `end_date` is provided, the API returns **absences with an exact match**.
- If both are provided, the API returns **absences within the specified date interval**.

## Flutter App

The Flutter app lives in the `sickness_manager/` folder. The API is located in the `api/` folder.

This Flutter application is built with a focus on clean architecture, modularity, and testability. It follows a **feature-first structure**, centered around domain entities and designed with **TDD** and **dependency injection** in mind.

The app is fully connected to a live API — no additional backend setup is required.  
You can log in using the following credentials:

- **Email:** `admin@crewmeister.com`
- **Password:** `admin123`

---

### Features

The app is structured into three main features:

#### 1. Login

- Authenticates the user using the `/login` endpoint.
- Stores the JWT access token securely for authenticated requests.
- Redirects the user to the Absences feature after login.

#### 2. Startup

- Initializes the app.
- Verifies the presence of a valid JWT token.
- Handles redirection between login and absence flow.

#### 3. Absence Management

This is the core of the app. It allows users to:

- Fetch a **paginated list** of absences
- Apply **multiple filters**:
  - Absence type (`vacation`, `sick leave`)
  - Status (`requested`, `confirmed`, `rejected`)
  - Member ID, Crew ID
  - Date range (`start_date`, `end_date`)
- View **detailed information** for each absence, including:
  - Member name and notes
  - Admitter notes (if present)
  - Period and status
- Export an absence as an **`.ics` iCal file**, which can be imported into Outlook, Google Calendar, or other calendar applications

---

### Architecture & Design Principles

- **Feature-first structure**: Each feature is fully isolated and unaware of the others.
- **Pure Dart ViewModels**: Business logic is managed using `ValueNotifier<T>`, with `immutable` state classes and a functional programming paradigm.
- **Unidirectional data flow**: Data flows from framework → repository → feature → viewmodel → UI.
- **Dependency Injection with Riverpod**: All dependencies (ViewModels, Repos, Data Sources) are registered using Riverpod providers.
- **Navigation via output contracts**: Each feature defines abstract output interfaces for navigation. The app router (based on GoRouter) implements those interfaces, achieving complete routing inversion.
- **Modularity**: Features are injected via "modules" that encapsulate all logic, providers, and dependencies needed for the feature to function independently.

---

### Getting Started

#### Web
```bash
flutter config --enable-web
flutter pub get
flutter run -d chrome
```

#### Android

```bash
flutter pub get
flutter run -d android
```
Ensure an emulator or physical device is connected.

#### iOS

```bash
cd ios
pod install
cd ..
flutter pub get
flutter run -d ios
```
Open the project in Xcode and configure code signing if needed.

---

## Testing
The app includes both unit and widget testing.

### Unit Tests
- `AbsenceRepository`
- `AbsenceViewModel`

These are tested in isolation to ensure data transformations and logic are correct.

### Widget Tests
The Absence screen is covered with widget tests to verify:
- Loading and error states
- List rendering
- Button interactions (e.g., logout, filter)

### To run tests
```bash
flutter test
```
