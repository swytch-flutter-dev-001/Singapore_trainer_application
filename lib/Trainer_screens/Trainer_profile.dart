import 'package:flutter/material.dart';
import 'package:singapore_trainer_app/Trainer_screens/edit_trainer_profile.dart';

class TrainerProfile extends StatefulWidget {
  const TrainerProfile({super.key});

  @override
  State<TrainerProfile> createState() => _TrainerProfileState();
}

class _TrainerProfileState extends State<TrainerProfile> {
  final TextEditingController _nameController = TextEditingController(text: "Tyson");
  final TextEditingController _emailController = TextEditingController(text: "tyson@example.com");
  final TextEditingController _phoneController = TextEditingController(text: "+65 1234 5678");
  final TextEditingController _experienceController = TextEditingController(text: "5 Years");
  final TextEditingController _specializationController = TextEditingController(text: "Strength Training");

  final Color primaryColor = const Color(0xFF659F62); // Preferred theme color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Trainer Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profile Picture with Edit Button
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage("https://via.placeholder.com/150"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EditTrainerProfile()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _nameController.text,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              // Profile Details in Read-Only Text Fields
              _buildReadOnlyField("Name", _nameController),
              const SizedBox(height: 10),
              _buildReadOnlyField("Email", _emailController),
              const SizedBox(height: 10),
              _buildReadOnlyField("Phone Number", _phoneController),
              const SizedBox(height: 10),
              _buildReadOnlyField("Experience", _experienceController),
              const SizedBox(height: 10),
              _buildReadOnlyField("Specialization", _specializationController),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build read-only fields
  Widget _buildReadOnlyField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: primaryColor.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
