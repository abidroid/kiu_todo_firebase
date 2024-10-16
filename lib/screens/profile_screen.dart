import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DocumentSnapshot? userData;

  bool fileChosen = false;
  File? chosenImageFile;

  getUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    userData =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {});
    print(userData!['name']);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  pickImageAndUploadToStorage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: imageSource);

    if (image == null) return;

    chosenImageFile = File(image.path);
    fileChosen = true;
    setState(() {});

    // upload file to storage
    // upload image to storage
    FirebaseStorage storage = FirebaseStorage.instance;

    var fileName = userData!['email'] + '.png';

    UploadTask uploadTask = storage
        .ref()
    //.child('profile_images')
        .child(fileName)
        .putFile(chosenImageFile!, SettableMetadata(contentType: 'image/png'));

    TaskSnapshot snapshot = await uploadTask;

    String profileImageUrl = await snapshot.ref.getDownloadURL();
    print(profileImageUrl);


    // save its url in users collection

    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'photo': profileImageUrl});

    Fluttertoast.showToast(msg: 'Image Uploaded');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Profile'),
      ),
      body: userData == null
          ? Center(
              child: SpinKitDualRing(color: Colors.green),
            )
          : Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: fileChosen
                      ? FileImage(chosenImageFile!) as ImageProvider
                      : userData!['photo'] == null
                          ? null
                          : NetworkImage(userData!['photo']),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.camera_alt),
                                        title: const Text('Camera'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          pickImageAndUploadToStorage(
                                              ImageSource.camera);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.photo),
                                        title: const Text('Gallery'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          pickImageAndUploadToStorage(
                                              ImageSource.gallery);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: Icon(Icons.camera_alt))),
                ),
                const Gap(20),
                Text('Name: ${userData!['name']}', textAlign: TextAlign.center),
                const Gap(20),
                Text('Email: ${userData!['email']}',
                    textAlign: TextAlign.center),
                const Gap(20),
                Text('Mobile: ${userData!['mobile']}',
                    textAlign: TextAlign.center),
              ],
            ),
    );
  }
}
