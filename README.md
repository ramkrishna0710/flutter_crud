# 📘 Student Manager App – Flutter + Firestore

A clean and modern Flutter application to manage student records using Firebase Firestore. It supports **Create**, **Read**, **Update**, and **Delete (CRUD)** operations with real-time UI updates and a reusable form modal for both adding and editing student information.

---

## 🚀 Features

- 🔥 Firebase Firestore integration
- ➕ Add new students
- ✏️ Edit existing student details
- 🗑️ Delete students with confirmation
- 🧩 Reusable form modal for Add/Edit
- ✅ Form validation
- 🔄 Real-time sync with Firestore using `StreamBuilder`
- 📱 Responsive and clean UI

---

## 📸 Screenshots
>
---

## 📂 Project Structure


---

## 🔧 Firestore Setup

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project
3. Enable Firestore in "Build > Firestore Database"
4. Add Android/iOS app to Firebase project
5. Download `google-services.json` and place in `android/app/`
6. Add Firebase SDKs as per [FlutterFire docs](https://firebase.flutter.dev/docs/overview/)

---

## 📦 Dependencies

Make sure your `pubspec.yaml` includes:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cloud_firestore: ^4.8.0
  firebase_core: ^2.26.0
