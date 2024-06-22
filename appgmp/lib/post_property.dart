
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appgmp/app_styles.dart';
import 'package:appgmp/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:permission_handler/permission_handler.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'dialog.dart';
import 'home_page.dart';

class PropertyPostController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telController = TextEditingController();
  RxString propertyTypeController = 'Residential'.obs;
  TextEditingController addressController = TextEditingController();
  RxString selectedImage = ''.obs;
  RxString validationState = ''.obs; // New state for validation
  BuildContext? _context;
  static PropertyPostController get instance => Get.find<PropertyPostController>();

  setContext(BuildContext context) {
    _context = context;
  }
  Future<String?> pickImage() async {
    try {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Return the path of the selected image
        return pickedFile.path;
      } else {
        // User canceled image picking
        return null;
      }
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  Future<void> postProperty() async {
    try {
      // Show loader dialog
      Get.dialog(Center(
        child: CircularProgressIndicator(),
      ));

      String name = nameController.text;
      String email = emailController.text;
      String tel = telController.text;
      String propertyType = propertyTypeController.value;
      String address = addressController.text;

      // Validate email
      if (!RegExp(
          r'^[a-zA-Z0-9._%+-]+@(gmail\.com|hotmail\.com|yahoo\.com|outlook\.com|getmyproperties\.com|reddif\.com)$')
          .hasMatch(email)) {
        validationState.value = 'error_email';
        return;
      }

      // Validate phone number
      if (tel.length != 10) {
        validationState.value = 'error_number';
        return;
      }

      // Connect to MongoDB
      final db = await mongo.Db.create(
          'mongodb+srv://sp:EyJqonVw4f9ghAUA@gmp.hjsqsex.mongodb.net/Orig');
      await db.open();

      // Access the collection
      final collection = db.collection('GMPAPP_postpropertymodel');

      // Find the document with the highest ID
      final document = await collection.findOne(
        mongo.where.sortBy('id', descending: true),
      );

      int latestId = document != null ? document['id'] ?? 0 : 0;

      // Increment the latest ID by 1
      int newId = latestId + 1;

      // Insert the new property with the calculated ID
      await collection.insertOne({
        'id': newId,
        'name': name,
        'email': email,
        'tel': '91$tel',
        'property_type': propertyType,
        'address': address,
        'image_files': 'img2.jpg'
      });

      // Close the database connection
      await db.close();

      // Reset validation state
      validationState.value = '';

      // Close the loader dialog
      Get.back();

      // Show success dialog
      QuickAlert.show(
        context: _context!,
        type: QuickAlertType.success,
        text: 'Property posted successfully!',
      );
      await Future.delayed(Duration(seconds: 4));
      nameController.clear();
      emailController.clear();
      telController.clear();
      propertyTypeController.value = 'Residential';
      addressController.clear();
      selectedImage.value = '';
      // Delay for 2 seconds (adjust as needed)
      Get.offAll(() => HomePage());
    } catch (e) {
      print('Error posting property: $e');
      // Reset validation state
      validationState.value = '';

      // Close the loader dialog
      Get.back();

      // Show generic error dialog

    }
  }


}

class PropertyPostPage extends StatefulWidget {
  const PropertyPostPage({Key? key}) : super(key: key);

  @override
  State<PropertyPostPage> createState() => _PropertyPostPageState();
}

class _PropertyPostPageState extends State<PropertyPostPage> {
  final _formKey = GlobalKey<FormState>();
  final PropertyPostController controller = Get.put(PropertyPostController());

  @override
  void initState() {
    super.initState();
    controller.setContext(context as BuildContext);
    // Request gallery permissions when the page is opened
    Permission.photos.request();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
            Row(
              children: [
                Image.asset(
                  'assets/logo1.png',
                  width: 200,
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: kPadding20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                'POST A PROPERTY',
                style: kRalewayMedium.copyWith(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal! * 6,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35, left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 2.0,
                    color: Colors.blue.shade600,
                  ),
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'Enter your name',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blue.shade600),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue.shade600),
                            ),
                            hintStyle: TextStyle(color: Colors.blue.shade900),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blue.shade600),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue.shade600),
                            ),
                            hintStyle: TextStyle(color: Colors.blue.shade900),
                          ),
                          validator: (value) {
                            if (value != null &&
                                !RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@(gmail\.com|hotmail\.com|yahoo\.com|outlook\.com|getmyproperties\.com|reddif\.com)$')
                                    .hasMatch(value)) {
                              return 'Enter Valid Email Address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: controller.telController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            hintText: 'Enter your phone number',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blue.shade600),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue.shade600),
                            ),
                            hintStyle: TextStyle(color: Colors.blue.shade900),
                          ),
                          validator: (value) {
                            if (value?.length != 10) {
                              return 'Phone number must be 10 digits';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: controller.propertyTypeController.value,
                          decoration: InputDecoration(
                            labelText: 'Property Type',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blue.shade600),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue.shade600),
                            ),
                            hintStyle: TextStyle(color: Colors.blue.shade900),
                          ),
                          onChanged: (String? newValue) {
                            controller.propertyTypeController.value = newValue!;
                          },
                          items: ['Residential', 'Commercial']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(value)),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: controller.addressController,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            hintText: 'Enter the property address',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blue.shade600),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue.shade600),
                            ),
                            hintStyle: TextStyle(color: Colors.blue.shade900),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            controller.pickImage();
                          },
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1.5,
                                color: Colors.blue.shade600,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload,
                                    color: Colors.blue.shade600,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Upload Image',
                                    style: TextStyle(
                                      color: Colors.blue.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            // Validate the form
                            if (_formKey.currentState!.validate()) {
                              // Check the validation state
                              if (controller.validationState.value.isEmpty) {
                                // Form is valid, proceed with postProperty
                                await controller.postProperty();
                              } else {
                                // Form is invalid, show an error dialog based on the validation state
                                Get.defaultDialog(
                                  title: 'Error',
                                  middleText: controller.validationState.value ==
                                      'error_email'
                                      ? 'Enter Valid Email Address'
                                      : 'Phone number must be 10 digits',
                                );
                              }
                            }
                          },
                          child: Text('Post Property'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
