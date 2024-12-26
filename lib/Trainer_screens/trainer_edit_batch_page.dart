import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';  // Import the Spinkit package

class EditBatch extends StatefulWidget {
  final Map<String, dynamic> batchDetails;

  const EditBatch({required this.batchDetails});

  @override
  _EditBatchState createState() => _EditBatchState();
}

class _EditBatchState extends State<EditBatch> {
  late TextEditingController nameCtrl;
  late TextEditingController daysCtrl;
  late TextEditingController timeSlotCtrl;
  late TextEditingController maxCapacityCtrl;
  bool _isLoading = false;  // This will track loading state

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.batchDetails['batchName']);
    daysCtrl = TextEditingController(text: widget.batchDetails['days']);
    timeSlotCtrl = TextEditingController(text: widget.batchDetails['timeSlot']);
    maxCapacityCtrl =
        TextEditingController(text: widget.batchDetails['maxCapacity'].toString());
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    daysCtrl.dispose();
    timeSlotCtrl.dispose();
    maxCapacityCtrl.dispose();
    super.dispose();
  }

  // Simulating a network call for updating the batch
  Future<void> updateBatch() async {
    setState(() {
      _isLoading = true;  // Show the loading spinner
    });

    // Simulating a delay (like an API call)
    await Future.delayed(Duration(seconds: 2));

    // After the update completes, create the updated batch
    Map<String, dynamic> updatedBatch = {
      'batchName': nameCtrl.text,
      'days': daysCtrl.text,
      'timeSlot': timeSlotCtrl.text,
      'maxCapacity': int.tryParse(maxCapacityCtrl.text) ?? 0,
      'enrolledLearners': widget.batchDetails['enrolledLearners'], // Preserve enrolled learners
    };

    // Pop the updated batch back to the previous screen
    Navigator.pop(context, updatedBatch);

    setState(() {
      _isLoading = false;  // Hide the loading spinner
    });
  }

  // Reusable method to build input fields
  Widget _buildInputField(String hintText, TextEditingController controller, {TextInputType inputType = TextInputType.text}) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      child: TextFormField(
        controller: controller,
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
          contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        ),
        validator: (value) => value!.isEmpty ? 'Enter $hintText' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF659F62), // Dark Green
        title: Text(
          ('Edit ${widget.batchDetails['batchName']}').toUpperCase(),
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: _isLoading
          ? Center(
        child: SpinKitFadingCube(
          color: Color(0xFF659F62), // Dark Green
          size: 50.0,
        ),
      )
          :
         Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                // Batch Name Field
                Text("Batch Name", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                _buildInputField("Batch Name", nameCtrl),
                SizedBox(height: 10.h),

                // Days Field
                Text("Days", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                _buildInputField("Days", daysCtrl),
                SizedBox(height: 10.h),

                // Time Slot Field
                Text("Time Slot", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                _buildInputField("Time Slot", timeSlotCtrl),
                SizedBox(height: 10.h),

                // Max Capacity Field
                Text("Max Capacity", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                _buildInputField("Max Capacity", maxCapacityCtrl, inputType: TextInputType.number),
                SizedBox(height: 30.h),

                // Update Button
                Center(
                  child: SizedBox(
                    height: 50.h,
                    width: 315.w,
                    child: ElevatedButton(
                      onPressed: updateBatch, // Disable button while loading
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF659F62),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
                      ),
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  }
}
