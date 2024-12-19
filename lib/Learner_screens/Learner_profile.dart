import 'package:flutter/material.dart';

class learner_profile extends StatefulWidget {
  const learner_profile({super.key});

  @override
  _learner_profileState createState() => _learner_profileState();
}

class _learner_profileState extends State<learner_profile> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController(text: "Tyson");
  final TextEditingController _ageController = TextEditingController(text: "25");
  final TextEditingController _placeController = TextEditingController(text: "Singapore");
  final TextEditingController _currentlyLearningController = TextEditingController(text: "Swimming");
  final TextEditingController _locationController = TextEditingController(text: "Singapore");
  final TextEditingController _phoneController = TextEditingController(text: "+65 1234 5678");
  final TextEditingController _emailController = TextEditingController(text: "tyson@example.com");

  final Color primaryColor = const Color(0xFF659F62); // Your preferred theme color

  // Placeholder for image (image picking not implemented for now)
  String _profileImageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        toolbarHeight: 80,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),

        title: const Text(
          "LEARNER PROFILE",
          style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                // Profile Picture and Name Field
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Implement image picker functionality
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _profileImageUrl.isEmpty
                              ? const AssetImage("assets/default_avatar.png") as ImageProvider
                              : NetworkImage(_profileImageUrl),
                          child: _profileImageUrl.isEmpty
                              ? const Icon(
                            Icons.add_a_photo,
                            size: 30,
                            color: Colors.grey,
                          )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _nameController.text,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Editable Fields
                _buildEditableField("Age", _nameController, "Enter your age"),
                const SizedBox(height: 10),
                _buildEditableField("Age", _ageController, "Enter your age"),
                const SizedBox(height: 10),
                _buildEditableField("Place", _placeController, "Enter your place"),
                const SizedBox(height: 10),
                _buildEditableField("Currently Learning", _currentlyLearningController, "Enter what you're learning"),
                const SizedBox(height: 10),
                _buildEditableField("Location", _locationController, "Enter your location"),
                const SizedBox(height: 10),
                _buildEditableField("Phone Number", _phoneController, "Enter your phone number", keyboardType: TextInputType.phone),
                const SizedBox(height: 10),
                _buildEditableField("Email", _emailController, "Enter your email", keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 20),

                // Save Changes Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Profile updated successfully!")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build editable fields
  Widget _buildEditableField(String label, TextEditingController controller, String hint,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextFormField(

          controller: controller,
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "$label cannot be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
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
