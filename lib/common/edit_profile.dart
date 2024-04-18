import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InfantProfilePage extends StatefulWidget {
  const InfantProfilePage({Key? key}) : super(key: key);

  @override
  _InfantProfilePageState createState() => _InfantProfilePageState();
}

class _InfantProfilePageState extends State<InfantProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  String currentuid = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _infantNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  void _saveInfantProfile() async {
    await FirebaseFirestore.instance
        .collection('mothers')
        .doc(currentuid)
        .update({
      'Gender': _genderController.text,
      'DateofBirth': _dobController.text,
      'Height': _heightController.text,
      'Name': _infantNameController.text,
      'Weight': _weightController.text,
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Infant profile updated successfully'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Infant Profile'),
            backgroundColor: const Color.fromARGB(255, 16, 89, 149)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Mothers')
                  .doc(currentuid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  print('No infant profile found for uid: $currentuid');
                  return const Center(child: Text('No infant profile found'));
                }

                Map<String, dynamic> infantData =
                    snapshot.data!.data() as Map<String, dynamic>;

                _dobController.text = infantData['DateofBirth'] ?? '';
                _infantNameController.text = infantData['InfantName'] ?? '';
                _heightController.text = infantData['Height'] ?? '';
                
                _weightController.text = infantData['Weight'] ?? '';
                _genderController.text = infantData['Gender'] ?? '';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTextField('Name', _infantNameController),
                    _buildTextField('Gender', _genderController),
                    _buildTextField('Weight', _weightController),
                    _buildTextField('Height', _heightController),
                    _buildTextField('Date of Birth', _dobController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 16, 89, 149)),
                      onPressed: () {
                        _saveInfantProfile();
                        Navigator.pop(context);
                      },
                      child: const Text('Save Profile'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}

Widget _buildTextField(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    ),
  );
}

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({Key? key}) : super(key: key);

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  String currentuid = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _instituteController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  void _saveDoctorProfile() async {
    await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(currentuid)
        .update({
      'Name': _nameController.text,
      'Age': _ageController.text,
      'Degree': _degreeController.text,
      'Speciality': _specialityController.text,
      'Institute': _instituteController.text,
      'EmailAddress': _emailController.text,
      'MobileNumber': _mobileNoController.text,
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Doctor profile updated successfully'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Doctor Profile'),
            backgroundColor: const Color.fromARGB(255, 16, 89, 149)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Doctors')
                  .doc(currentuid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  print('No infant profile found for uid: $currentuid');
                  return const Center(child: Text('No doctor profile found'));
                }

                Map<String, dynamic> infantData =
                    snapshot.data!.data() as Map<String, dynamic>;

                _nameController.text = infantData['Name'] ?? '';
                _ageController.text = infantData['Age'] ?? '';
                _degreeController.text = infantData['Degree'] ?? '';
                _specialityController.text = infantData['Speciality'] ?? '';
                _instituteController.text = infantData['Institute'] ?? '';
                _experienceController.text = infantData['Experience'] ?? '';
                _emailController.text = infantData['EmailAddress'] ?? '';
                _mobileNoController.text = infantData['MobileNumber'] ?? '';
                _genderController.text = infantData['Gender'] ?? '';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTextField('Name', _nameController),
                    _buildTextField('Age', _ageController),
                    _buildTextField('Degree', _degreeController),
                    _buildTextField('Speciality', _specialityController),
                    _buildTextField('Institute', _instituteController),
                    _buildTextField('EmailAddress', _emailController),
                    _buildTextField('Mobile Number', _mobileNoController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 16, 89, 149)),
                      onPressed: () {
                        _saveDoctorProfile();
                        Navigator.pop(context);
                      },
                      child: const Text('Save Profile'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}

class MotherProfilePage extends StatefulWidget {
  const MotherProfilePage({Key? key}) : super(key: key);

  @override
  _MotherProfilePageState createState() => _MotherProfilePageState();
}

class _MotherProfilePageState extends State<MotherProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  String currentuid = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _adhaarNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _infantNameController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  void _saveMotherProfile() async {
    await FirebaseFirestore.instance
        .collection('mothers')
        .doc(currentuid)
        .update({
      'Address': _addressController.text,
      'AdhaarNumber': _adhaarNumberController.text,
      'EmailAddress': _emailController.text,
      'FatherName': _fatherNameController.text,
      'Name': _infantNameController.text,
      'MotherName': _motherNameController.text,
      'MobileNumber': _mobileNoController.text,
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Mother profile updated successfully'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Mother Profile'),
            backgroundColor: const Color.fromARGB(255, 16, 89, 149)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Mothers')
                  .doc(currentuid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  print('No infant profile found for uid: $currentuid');
                  return const Center(child: Text('No infant profile found'));
                }

                Map<String, dynamic> infantData =
                    snapshot.data!.data() as Map<String, dynamic>;

                _addressController.text = infantData['Address'] ?? '';
                _adhaarNumberController.text = infantData['AdhaarNumber'] ?? '';
                _emailController.text = infantData['EmailAddress'] ?? '';
                _fatherNameController.text = infantData['FatherName'] ?? '';
                _motherNameController.text = infantData['MotherName'] ?? '';
                _infantNameController.text = infantData['InfantName'] ?? '';
                _mobileNoController.text = infantData['MobileNumber'] ?? '';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTextField('Infant Name', _infantNameController),
                    _buildTextField('Father Name', _fatherNameController),
                    _buildTextField('Mother Name', _motherNameController),
                    _buildTextField('Email Address', _emailController),
                    _buildTextField('Address', _addressController),
                    
                    _buildTextField('Mobile Number', _mobileNoController),
                    _buildTextField('Adhaar Number', _adhaarNumberController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 16, 89, 149)),
                      onPressed: () {
                        _saveMotherProfile();
                        Navigator.pop(context);
                      },
                      child: const Text('Save Profile'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
