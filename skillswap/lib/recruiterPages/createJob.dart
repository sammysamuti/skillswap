import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../Project/projectcontroller.dart';
import '../Project/userdata.dart';
import '../firebase/firebase.dart';
import '../widgets/buttons.dart';

class PostJobForm extends StatefulWidget {
  const PostJobForm({super.key});

  @override
  State<PostJobForm> createState() => _PostJobFormState();
}

class _PostJobFormState extends State<PostJobForm> {
  final _jobtitleController = TextEditingController();
  final _jobdescriptionController = TextEditingController();
  final _requirementcontroller = TextEditingController();
  final _locationcontroller = TextEditingController();
  final _salaryrangecontroller = TextEditingController();
  late final UserController usercontroller;
  late final ProjectController projectController;
  late final Firebase_Service _auth;
  List<String> _selectedSkills = [];
  bool _isLoading = false;

  bool _obscureText = true;
  String? imagePath;
  File? _image;
  String? downloadUrl;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    // For mobile platforms, set the image directly
    final imageTemp = File(image.path);
    setState(() {
      imagePath = imageTemp.path;
      _image = imageTemp;
    });
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now()}.jpg');

    try {
      // Upload the image to Firebase Storage
      await storageReference.putFile(_image!);

      // Retrieve the download URL of the uploaded image
      downloadUrl = await storageReference.getDownloadURL();
    } catch (e) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $e');
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _auth = Firebase_Service(context);
    usercontroller = Get.put(UserController());
    projectController = Get.put(ProjectController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              Text(
                'Create Job Posting',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Center(
                child: Stack(children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage:
                        imagePath != null ? FileImage(File(imagePath!)) : null,
                    child: imagePath == null
                        ? Icon(
                            Icons.person,
                            size: 50,
                          )
                        : null,
                  ),
                  Positioned(
                    top: 45,
                    right: -10,
                    child: Icon(Icons.add, size: 15),
                  )
                ]),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const FormText(
                  text: "Job Title", alignment: Alignment.centerLeft),
              CustomTextFormField(
                width: width * 0.9,
                height: height * 0.06,
                hintText: "Job Title",
                controller: _jobtitleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Job Title';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const FormText(
                  text: "Job Description", alignment: Alignment.centerLeft),
              CustomTextFormField(
                width: width * 0.9,
                height: height * 0.06,
                hintText: "Job Description",
                controller: _jobtitleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Job Description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const FormText(
                  text: "Requirements", alignment: Alignment.centerLeft),
              CustomTextFormField(
                width: width * 0.9,
                height: height * 0.06,
                hintText: "Requirements",
                controller: _jobtitleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Requirements';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const FormText(text: "Location", alignment: Alignment.centerLeft),
              CustomTextFormField(
                width: width * 0.9,
                height: height * 0.06,
                hintText: "Location",
                controller: _jobtitleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Location';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const FormText(
                  text: "Salary Range", alignment: Alignment.centerLeft),
              CustomTextFormField(
                width: width * 0.9,
                height: height * 0.06,
                hintText: "Salary Range",
                controller: _jobtitleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Salary Range';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 40,
              ),
              ButtonTwoLoading("Post", Colors.white, Color(0XFF2E307A),
                  width * 0.8, height * 0.07, 16, () {
                if (_formKey.currentState!.validate() && !_isLoading) {
                  // form is valid, submit the form
                  _postJob();
                }
              }, _isLoading),
            ],
          ),
        ),
      ),
    );
  }

  void _postJob() {
    //fill
  }
}
