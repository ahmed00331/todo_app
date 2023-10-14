import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/userModel.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJason(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJason();
      },
    );
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJason(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJason();
      },
    );
  }

  static Future<void> addUsersToFirestore(UserModel userModel) {
    var collection = getUsersCollection();
    var docRef = collection.doc(userModel.id);
    return docRef.set(userModel);
  }

  static void deleteTask(String id) {
    getTasksCollection().doc(id).delete();
  }

  static void updateTask(TaskModel task) {
    getTasksCollection().doc(task.id).update(task.toJason());
  }

  static void updateTaskTitle(TaskModel task) {
    getTasksCollection().doc(task.title).update(task.toJason());
  }

  static void updateTaskDescription(TaskModel task) {
    getTasksCollection().doc(task.description).update(task.toJason());
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime dateTime) {
    return getTasksCollection()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> addTask(TaskModel taskModel) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Future<void> createUser(String name, int age, String email,
      String password, Function onSuccess, Function onError) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user?.uid != null) {
        UserModel user = UserModel(
            id: credential.user!.uid, email: email, name: name, age: age);
        addUsersToFirestore(user).then((value) {
          onSuccess();
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
        print('The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> login(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user?.uid != null) {
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      onError("Wrong Email or Password");
    }
  }

  static Future<UserModel?> readUserFromFirestore(String id) async {
    DocumentSnapshot<UserModel> doc = await getUsersCollection().doc(id).get();
    return doc.data();
  }
}
