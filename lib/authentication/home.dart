import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_banner/authentication/login.dart';
import 'package:my_banner/authentication/register.dart';
import 'package:my_banner/screens/note_detail.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  XFile? _selectedImage;
  String? _imageUrl; // To store the uploaded image URL

  Future<void> _saveData() async {
    // First, upload the image to Firebase Storage
    if (_selectedImage != null) {
      try {
        // Get a reference to the storage service
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('user_images/${DateTime.now().toIso8601String()}');

        // Upload the file to Firebase Storage
        UploadTask uploadTask =
            storageReference.putFile(File(_selectedImage!.path));

        // Wait for the upload to complete and grab the download URL
        await uploadTask.whenComplete(() async {
          _imageUrl = await storageReference.getDownloadURL();
          log('File Uploaded - $_imageUrl');
        });
      } catch (e) {
        log('Error uploading image: $e');
      }
    }

    // Now, save the user data including image URL to Firestore
    await _usersCollection.add({
      'name': _nameController.text,
      'email': _emailController.text,
      'age': int.tryParse(_ageController.text) ?? 0,
      'image_url': _imageUrl ?? '', // Store image URL in Firestore
    });

    _clearFields();
  }

  void _clearFields() {
    _nameController.clear();
    _emailController.clear();
    _ageController.clear();
    setState(() {
      _selectedImage = null;
      _imageUrl = null;
    });
  }

  void _deleteData(String docId) async {
    await _usersCollection.doc(docId).delete();
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void getInitialMessage() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      if (message.data["page"] == "email") {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => NoteDetail()));
      } else if (message.data["page"] == "phone") {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => Register()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid page!"),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    getInitialMessage();
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message.notification!.body.toString()),
            duration: const Duration(seconds: 60),
            backgroundColor: Colors.green,
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("App was opened by a  notification"),
          duration: const Duration(seconds: 10),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CupertinoButton(
                onPressed: () async {
                  XFile? selectedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (selectedImage != null) {
                    setState(() {
                      _selectedImage = selectedImage;
                    });
                    log("Image selected: ${selectedImage.path}");
                  } else {
                    log("No Image selected");
                  }
                },
                padding: EdgeInsets.zero,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage: _selectedImage != null
                      ? FileImage(File(_selectedImage!.path))
                      : null,
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveData,
                child: Text('Save'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final data = document.data() as Map<String, dynamic>;

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: data['image_url'] != null &&
                                    data['image_url'].isNotEmpty
                                ? NetworkImage(data['image_url'])
                                : AssetImage('assets/default_avatar.png')
                                    as ImageProvider,
                          ),
                          title: Text(data['name']),
                          subtitle: Text(
                              'Email: ${data['email']} - Age: ${data['age']}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteData(document.id),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
