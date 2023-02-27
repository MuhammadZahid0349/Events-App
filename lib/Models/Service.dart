import 'dart:io';

import 'package:event_management/Constants/utils.dart';
import 'package:event_management/Models/UserModels.dart';
import 'package:event_management/Screen/Profile%20Screens/Create_Profile.dart';
import 'package:event_management/Screen/Home_Bottom_Menu.dart';
import 'package:event_management/Screen/MyHomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;

var auth = FirebaseAuth.instance;
var firestore = FirebaseFirestore.instance;
var fbStorage = FirebaseStorage.instance;
var currentUserData = auth.currentUser?.uid;
var UserModelData = UserModel();

signUp(String email, String password) async {
  try {
    EasyLoading.show();

    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    //////// Send data firebase by the help of User Model ///////////////////////
    UserModel newUser = UserModel(
      uid: credential.user?.uid,
      userPassword: password,
      userEmail: email,
    );
    await firestore_set("users", credential.user?.uid, newUser.toMap());
//////////////////////////////////////////////////////////
    EasyLoading.dismiss();

    Get.to(() => CProfileScreen());
  } on FirebaseAuthException catch (e) {
    EasyLoading.dismiss();

    if (e.code == 'weak-password') {
      CustomizedSnackBar("Weak-Password", "Password Provided is too weak...");
    } else if (e.code == 'email-already-in-use') {
      CustomizedSnackBar("Account", "Account already exists...");
    } else {
      CustomizedSnackBar("From Database", e.code);
    }
  }
}

firestore_set(collection, doc, set) async {
  doc != null
      ? await firestore
          .collection(collection.toString())
          .doc(doc.toString())
          .set(set)
      : await firestore.collection(collection.toString()).add(set);
}

firestore_update(collection, doc, data) async {
  // final DocumentReference Docreference =
  //     firestore.collection(collection).doc(doc);
  // return await Docreference.update(data);
  var dat = await firestore.collection("$collection").doc("$doc").update(data);
  return dat;
}

// firestore_get(collection, doc) async {
//   try {
//     EasyLoading.show();
//     DocumentSnapshot userData =
//         await firestore.collection(collection).doc(doc).get();
//     EasyLoading.dismiss();
//     return userData;
//   } on FirebaseException catch (e) {
//     EasyLoading.dismiss();
//     CustomizedSnackBar("From Database", e.message);
//     print(e);
//   } catch (e) {
//     EasyLoading.dismiss();
//     print(e);
//     CustomizedSnackBar("From Database", e);
//   }
// }

void login(String? email, String? password) {
  EasyLoading.show();
  auth
      .signInWithEmailAndPassword(email: email!, password: password!)
      .then((value) {
    EasyLoading.dismiss();
    Get.to(() => HomeBottomMenuBar());
  }).catchError((e) {
    EasyLoading.dismiss();
    CustomizedSnackBar("", e);
  });
}

void forgetPassword(String email) {
  auth.sendPasswordResetEmail(email: email).then((value) {
    Get.back();
    CustomizedSnackBar(
        "Email has been Sent", "We have sent password reset email");
  }).catchError((e) {
    CustomizedSnackBar("Error In Sending Password ", e);
  });
}

void signInWithGoogle() async {
  try {
    EasyLoading.show();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await auth.signInWithCredential(credential);

    //////// Send data firebase by the help of User Model ///////////////////////
    UserModel newUser = UserModel(
      uid: userCredential.user?.uid,
      userEmail: userCredential.user?.email,
      userFName: userCredential.user?.displayName,
    );
    await firestore_set("users", userCredential.user?.uid, newUser.toMap());
    EasyLoading.dismiss();
    Get.to(() => HomeBottomMenuBar());
//////////////////////////////////////////////////////////
    // auth.signInWithCredential(credential).then((value) {
    //   EasyLoading.dismiss();
    //   Get.to(() => HomeBottomMenuBar());
    // }).catchError((e) {
    //   EasyLoading.dismiss();
    //   CustomizedSnackBar("", e);
    // });
  } on FirebaseAuthException catch (e) {
    EasyLoading.dismiss();
    CustomizedSnackBar("PlatForm Exception", e);
  }
}

Future<String> uploadImageToFirebaseStorage(File image) async {
  String imageUrl = "";
  String fileName = Path.basename(image.path);
  var reference = fbStorage.ref().child('profileImages/$fileName');
  UploadTask uplaodTask = reference.putFile(image);
  TaskSnapshot taskSnapshot = await uplaodTask.whenComplete(() => null);
  await taskSnapshot.ref.getDownloadURL().then((value) {
    imageUrl = value;
  }).catchError((e) {});
  return imageUrl;
}

///////////// Without Model 
// uploadProfileData(String? imageUrl, String? firstName, String? lastName,
//     String? mobileNumber, String? dob, String? gender) {
//   String uid = auth.currentUser!.uid;
//   firestore.collection('users').doc(uid).set({
//     'image': imageUrl,
//     'first': firstName,
//     'last': lastName,
//     'dob': dob,
//     'gender': gender
//   }).then((value) {
//     EasyLoading.dismiss();
//     Get.offAll(() => HomeBottomMenuBar()); //check
//   });
// }
