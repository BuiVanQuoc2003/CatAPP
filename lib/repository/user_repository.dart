import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  static final UserRepository instance = UserRepository._internal();

  UserRepository._internal();

  final _firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future signIn(
    String email,
    String password,
  ) async {
    try {
      final res = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return res.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == "unknown" ||
          e.code == "invalid-email") {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
      return 'Login failed';
    }
  }

  Future signUp(String email, String pass) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
      final user = await sendVerify(userCredential.user);
      await insertUserToFireStore(user!);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<User?> sendVerify(User? user) async {
    await user?.sendEmailVerification();
    return user;
  }

  Future<void> insertUserToFireStore(User user) async {
    try {
      final doc = firestore.collection('users').doc(user.uid);

      final getDoc = await doc.get();
      if (getDoc.exists) return;

      await doc.set({
        "idUser": user.uid,
        "email": user.email,
        "name": user.displayName ?? user.email,
      });
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return ('The email address is not valid.');
      } else if (e.code == 'user-not-found') {
        return ('There is no user corresponding to this email.');
      }
      return e.message;
    }
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}
