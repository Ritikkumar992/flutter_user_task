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
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                {
                  return const Center(child: CircularProgressIndicator());
                }
                else if (snapshot.hasError) {
                  return Text('error: ${snapshot.error}');
                }
                else {
                  List<User> users = snapshot.data!;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, idx) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
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
                                    fontSize: 30,
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
                                          UpdateUserPage(user: users[idx]),
                                    ),
                                  ).then((_) {
                                    setState(() {});
                                  });
                                },
                                child: const Icon(
                                  Icons.edit,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  await deleteUser(users[idx].id!);
                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.delete,
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
