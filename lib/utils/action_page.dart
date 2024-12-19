import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AdminActionsPage extends StatefulWidget {
  @override
  _AdminActionsPageState createState() => _AdminActionsPageState();
}

class _AdminActionsPageState extends State<AdminActionsPage> {
  final List<User> users = [
    User(name: 'John Doe', role: 'Trainer'),
    User(name: 'Jane Smith', role: 'Learner'),
    User(name: 'Michael Johnson', role: 'Trainer'),
    User(name: 'Emily Davis', role: 'Learner'),
  ];

  User? selectedUser;
  String? selectedAction;
  final TextEditingController reasonController = TextEditingController();

  final List<String> actions = ['Warn', 'Suspend', 'Remove'];

  bool isLoading = false;

  void submitAction() async {
    if (selectedUser == null || selectedAction == null || reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete all fields')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulate a delay to mimic network request
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${selectedAction} action taken against ${selectedUser!.name} (${selectedUser!.role}) for reason: ${reasonController.text}',
        ),
      ),
    );

    // Clear the form
    setState(() {
      selectedUser = null;
      selectedAction = null;
      reasonController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'ADMIN ACTIONS',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Color(0xFF659F62),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 6,
                shadowColor: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildSectionTitle('Select User'),
                      SizedBox(height: 10),
                      _buildDropdown<User>(
                        hint: 'Choose a user',
                        value: selectedUser,
                        items: users,
                        itemBuilder: (user) => '${user.name} (${user.role})',
                        onChanged: (User? newValue) => setState(() => selectedUser = newValue),
                      ),
                      SizedBox(height: 20),
                      _buildSectionTitle('Select Action'),
                      SizedBox(height: 10),
                      _buildDropdown<String>(
                        hint: 'Choose an action',
                        value: selectedAction,
                        items: actions,
                        itemBuilder: (action) => action,
                        onChanged: (String? newValue) => setState(() => selectedAction = newValue),
                      ),
                      SizedBox(height: 20),
                      _buildSectionTitle('Reason'),
                      SizedBox(height: 10),
                      _buildReasonInput(),
                      SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: submitAction,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Color(0xFF659F62),
                            elevation: 4,
                          ),
                          child: Text(
                            'Submit Action',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Center(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: SpinKitFadingCube(
                  color: Color(0xFF659F62),
                  size: 50.0,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF659F62)),
    );
  }

  Widget _buildDropdown<T>({
    required String hint,
    required T? value,
    required List<T> items,
    required String Function(T) itemBuilder,
    required void Function(T?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF92C287)),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          hint: Text(hint),
          value: value,
          icon: Icon(Icons.arrow_drop_down, color: Color(0xFF659F62)),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemBuilder(item)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildReasonInput() {
    return TextField(
      controller: reasonController,
      decoration: InputDecoration(
        hintText: 'Enter the reason for this action',
        filled: true,
        fillColor: Color(0xFFF8F9FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF92C287)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF659F62)),
        ),
      ),
      maxLines: 3,
    );
  }
}

class User {
  final String name;
  final String role;

  User({required this.name, required this.role});
}
