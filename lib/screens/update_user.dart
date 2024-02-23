import 'package:flutter/material.dart';
import '../model/user.dart';
import '../user_database/user_data.dart';

class UpdateUserClass extends StatefulWidget {
  final User user;

  const UpdateUserClass({super.key, required this.user});

  @override
  _UpdateUserClassState createState() => _UpdateUserClassState();
}

class _UpdateUserClassState extends State<UpdateUserClass> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  String selectedGender = '';

  final UserData userRepository = UserData();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
    numberController.text = widget.user.phoneNumber;
    selectedGender = widget.user.gender;
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
                'Update User',
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: 'User Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: numberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),

                ),
                const SizedBox(height: 16.0),
                const Text('Gender:'),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          selectedGender = value ?? '';
                        });
                      },
                    ),
                    const Text('Male'),
                    Radio<String>(
                      value: 'Female',
                      groupValue: selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          selectedGender = value ?? '';
                        });
                      },
                    ),
                    const Text('Female'),
                    Radio<String>(
                      value: 'Other',
                      groupValue: selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          selectedGender = value ?? '';
                        });
                      },
                    ),
                    const Text('Other'),
                  ],
                ),
                const SizedBox(height: 16.0),
                MaterialButton(
                  color: Colors.deepPurple,
                  height: 40,
                  onPressed: () async {
                    User updatedUser = User(
                      id: widget.user.id,
                      name: nameController.text,
                      phoneNumber: numberController.text,
                      gender: selectedGender,
                    );
                    await userRepository.updateUser(updatedUser);
                      Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'User Updated Successfully 🤡',
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
                  },
                  child: const Text(
                      'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
