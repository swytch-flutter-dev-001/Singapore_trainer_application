import 'package:flutter/material.dart';

class AdminProfileEditPage extends StatefulWidget {
  const AdminProfileEditPage({super.key});

  @override
  _AdminProfileEditPageState createState() => _AdminProfileEditPageState();
}

class _AdminProfileEditPageState extends State<AdminProfileEditPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController(text: "Tyson");
  final TextEditingController _companyController = TextEditingController(text: "New Future Agency");
  final TextEditingController _expertiseController = TextEditingController(text: "Strength Training");
  final TextEditingController _phoneController = TextEditingController(text: "+65 1234 5678");

  final Color primaryColor = const Color(0xFF659F62); // Your preferred theme color

  // Placeholder for image (image picking not implemented for now)
  String _profileImageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:Icon(Icons.arrow_back)),
        centerTitle: true,
        title:  Text("Admin Profile",style: TextStyle(color: Colors.white),),
        backgroundColor:Color(0xFF659F62),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),

          child: Center(
            child: Column(
              children: [
                // Editable Form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Picture Field
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
                            const Text(
                              "Name",
                              style: TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Editable Fields
                      _buildEditableField("Name", _nameController, "Enter your name"),
                      const SizedBox(height: 10),
                      _buildEditableField("Company Name", _companyController, "Enter your company name"),
                      const SizedBox(height: 10),
                      _buildEditableField("Expertise", _expertiseController, "Enter your expertise"),
                      const SizedBox(height: 10),
                      _buildEditableField("Phone Number", _phoneController, "Enter your phone number",
                          keyboardType: TextInputType.phone),
                      const SizedBox(height: 10),

                      // Save Changes Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
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
