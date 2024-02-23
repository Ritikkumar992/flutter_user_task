import 'package:flutter/material.dart';
import '../screens/add_user.dart';
import '../model/user.dart';
import '../user_database/user_data.dart';
import '../screens/update_user.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final UserData userdata = UserData();

  Future<void> deleteUser(int userId) async {
    await userdata.deleteUser(userId);
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
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
            ),
            child: const Center(
              child: Text(
                'User List',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<User>>(
              future: userdata.getUsers(),
              builder: (context, frame) {
                if (frame.connectionState == ConnectionState.waiting)
                {
                  return const Center(child: CircularProgressIndicator());
                }
                else if (frame.hasError) {
                  return Text('error: ${frame.error}');
                }
                else {
                  List<User> users = frame.data!;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, idx) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: double.infinity, // 80% of screen width
                          height: MediaQuery.of(context).size.height * 0.2, // 30% of screen height
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.7,
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '👤${users[idx].name}\n  ${users[idx].gender}\n📱 ${users[idx].phoneNumber}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateUserClass(user: users[idx]),
                                    ),
                                  ).then((_) {
                                    setState(() {});
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black, // Border color
                                      width: 1, // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(8), // Border radius
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 30.0,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    await deleteUser(users[idx].id!);
                                    setState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'User Deleted 💀',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        backgroundColor: Colors.red,
                                        elevation: 6,
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black, // Border color
                                        width: 1, // Border width
                                      ),
                                      borderRadius: BorderRadius.circular(8), // Border radius
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      size: 30.0,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          MaterialButton(
            height: 50,
            minWidth: double.infinity,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddUserClass(),
                ),
              );
              setState(() {});
            },
            color: Colors.deepPurple,
            textColor: Colors.white,
            child: Text(
              'Add User',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
