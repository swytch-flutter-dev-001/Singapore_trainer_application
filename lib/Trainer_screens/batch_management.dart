import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:singapore_trainer_app/Trainer_screens/trainer_adding_batches_page.dart';
import 'package:singapore_trainer_app/Trainer_screens/trainer_edit_batch_page.dart';

class BatchManagementPage extends StatefulWidget {
  @override
  _BatchManagementPageState createState() => _BatchManagementPageState();
}

class _BatchManagementPageState extends State<BatchManagementPage> {
  List<Map<String, dynamic>> batches = [
    {
      'batchName': 'Yoga Beginners',
      'days': 'Mon, Wed, Fri',
      'timeSlot': '10:00 AM - 12:00 PM',
      'maxCapacity': 20,
      'enrolledLearners': 12,
    },
    {
      'batchName': 'Advanced Pilates',
      'days': 'Tue, Thu',
      'timeSlot': '2:00 PM - 4:00 PM',
      'maxCapacity': 15,
      'enrolledLearners': 10,
    }
  ];

  bool _isLoading = false; // Loading state

  void _navigateToAddBatchPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBatchPage(onAddBatch: _addBatch),
      ),
    );
  }

  void _addBatch(Map<String, dynamic> newBatch) {
    setState(() {
      _isLoading = true; // Start loading
    });

    // Simulate a delay for the process (e.g., API call)
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        batches.add(newBatch);
        _isLoading = false; // Stop loading
      });
    });
  }

  void _navigateToBatchDetailsPage(Map<String, dynamic> batch) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BatchDetailPage(batchDetails: batch),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
          backgroundColor: Color(0xFF659F62),
          child: Icon(Icons.add),
          onPressed: _navigateToAddBatchPage,

      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70.h,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF659F62),
        title: Text(
          'BATCH MANAGEMENT',
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.add),
        //     onPressed: _navigateToAddBatchPage,
        //   ),
        // ],
      ),
      body: _isLoading
          ? Center(
              child: SpinKitFadingCube(
                color: Color(0xFF659F62), // Dark Green
                size: 50.0,
              ),
            )
          : ListView.builder(
              itemCount: batches.length,
              itemBuilder: (context, index) {
                var batch = batches[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x30659F62),
                        blurRadius: 5.r,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(batch['batchName']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Days: ${batch['days']}'),
                        Text('Time Slot: ${batch['timeSlot']}'),
                        Text('Max Capacity: ${batch['maxCapacity']}'),
                        Text('Enrolled Learners: ${batch['enrolledLearners']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            final updatedBatch = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditBatch(batchDetails: batches[index]),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              batches.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                    onTap: () => _navigateToBatchDetailsPage(batch),
                  ),
                );
              },
            ),
    );
  }
}

class AddBatchPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddBatch;

  AddBatchPage({required this.onAddBatch});

  @override
  _AddBatchPageState createState() => _AddBatchPageState();
}

class _AddBatchPageState extends State<AddBatchPage> {
  final _formKey = GlobalKey<FormState>();
  String? _batchName, _days, _timeSlot;
  int? _maxCapacity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70.h,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'CREATE NEW BATCH',
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
        backgroundColor: Color(0xFF659F62),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Form(
            // Wrap with Form widget
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                // Batch Name Field
                Text("Batch Name",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                _buildInputField("Batch Name", (value) => _batchName = value),
                SizedBox(height: 10.h),

                // Days Field
                Text("Days",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                _buildInputField(
                    "Days (e.g., Mon, Wed, Fri)", (value) => _days = value),
                SizedBox(height: 10.h),

                // Time Slot Field
                Text("Time Slot",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                _buildInputField("Time Slot (e.g., 10:00 AM - 12:00 PM)",
                    (value) => _timeSlot = value),
                SizedBox(height: 10.h),

                // Max Capacity Field
                Text("Max Capacity",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                _buildInputField(
                  "Max Capacity",
                  (value) => _maxCapacity = int.tryParse(value ?? ''),
                  inputType: TextInputType.number,
                ),
                SizedBox(height: 30.h),

                // Add Batch Button
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 315,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          widget.onAddBatch({
                            'batchName': _batchName ?? '',
                            'days': _days ?? '',
                            'timeSlot': _timeSlot ?? '',
                            'maxCapacity': _maxCapacity ?? 0,
                            'enrolledLearners': 0,
                          });
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF659F62),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 50.w, vertical: 10.h),
                      ),
                      child: Text(
                        "Add Batch",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
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

  // Reusable method to build input fields
  Widget _buildInputField(String hintText, Function(String?) onSaved,
      {TextInputType inputType = TextInputType.text}) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      child: TextFormField(
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11.r),
            borderSide: BorderSide(color: Color(0x50659F62), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11.r),
            borderSide: BorderSide(color: Color(0x50659F62), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11.r),
            borderSide: BorderSide(color: Color(0xFF659F62), width: 1.5),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        ),
        onSaved: onSaved,
        validator: (value) => value!.isEmpty ? 'Enter $hintText' : null,
      ),
    );
  }
}
