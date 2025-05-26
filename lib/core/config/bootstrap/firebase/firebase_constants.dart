import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 🧩 [usersCollection] — Firestore reference to the `users` collection
/// 📦 Used for fetching and storing user-specific data
//----------------------------------------------------------------//
final usersCollection = FirebaseFirestore.instance.collection('users');

/// 🧩 [fbAuth] — Firebase Authentication instance
/// 📦 Provides access to Firebase user-related auth methods
//----------------------------------------------------------------//
final fbAuth = FirebaseAuth.instance;
