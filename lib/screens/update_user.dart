import 'package:flutter/material.dart';
import '../model/user.dart';
import '../user_database/user_data.dart';

class UpdateUserPage extends StatefulWidget {
  final User user;

  const UpdateUserPage({super.key, required this.user});

  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
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
        title: const Text('Update User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              },
              child: const Text(
                  'Update',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
