import 'package:flutter/material.dart';
import '../model/user.dart';
import '../user_database/user_data.dart';

class AddUserClass extends StatefulWidget {
  const AddUserClass({super.key});

  @override
  _AddUserClassState createState() => _AddUserClassState();
}

class _AddUserClassState extends State<AddUserClass> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  String gender = '';

  final UserData userData = UserData();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a user name';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: const Center(
              child: Text(
                'Add User',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: Colors.grey,
              width: 1.7,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  validator: validateName,
                  decoration: InputDecoration(
                      labelText: 'User Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
                SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: numberController,
                  validator: validatePhoneNumber,
                  decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
                const SizedBox(height: 16.0),
                const Text('Gender', style: TextStyle(color: Colors.deepPurple, fontSize: 16.0),),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: gender,
                      onChanged: (String? value) {
                        setState(() {
                          gender = value ?? '';
                        });
                      },
                    ),
                    const Text('Male'),
                    Radio<String>(
                      value: 'Female',
                      groupValue: gender,
                      onChanged: (String? value) {
                        setState(() {
                          gender = value ?? '';
                        });
                      },
                    ),
                    const Text('Female'),
                    Radio<String>(
                      value: 'Other',
                      groupValue: gender,
                      onChanged: (String? value) {
                        setState(() {
                          gender = value ?? '';
                        });
                      },
                    ),
                    const Text('Other'),
                  ],
                ),
                const SizedBox(height: 26.0),
                MaterialButton(
                  color: Colors.deepPurple,
                  height: 40,
                  onPressed: () async {
                    if (_validateForm()) {
                      User newUser = User(
                        name: nameController.text,
                        phoneNumber: numberController.text,
                        gender: gender,
                      );
                      await userData.insertUser(newUser);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'New User Added Successfully 💚',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.green,
                          elevation: 6,
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    if (validateName(nameController.text) != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please Enter Your User Name ⚠️',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.redAccent,
          elevation: 6,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
      return false;
    }
    if (validatePhoneNumber(numberController.text) != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter a valid phone number ⚠️',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.redAccent,
          elevation: 6,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
      return false;
    }
    if (gender.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please Select your gender ⚠️',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.redAccent,
          elevation: 6,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
      return false;
    }
    return true;
  }
}
