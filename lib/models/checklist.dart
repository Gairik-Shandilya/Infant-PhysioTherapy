import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:physiotherapy/firestore_services.dart/m_services.dart';

class ChecklistItem {
  String id;
  String text;
  String choice;

  ChecklistItem({
    required this.id,
    required this.text,
    required this.choice,
  });

  factory ChecklistItem.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ChecklistItem(
      id: snapshot.id,
      text: data['text'] ?? '',
      choice: data['choice'] ?? '',
    );
  }
}

class DoctorChecklistPage extends StatelessWidget {
  String month = '1';
  DoctorChecklistPage({super.key, required this.month});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _addItemController = TextEditingController();

  Future<void> _addItem() async {
    User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;

      await FirebaseFirestore.instance
          .collection('checklist')
          .doc(month)
          .collection('questions')
          .add({
        'doctorId': userId,
        'text': _addItemController.text,
        'choice': '',
      });

      _addItemController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _addItemController,
                    decoration: const InputDecoration(
                      hintText: 'Add checklist item...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addItem,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MotherChecklistPage extends StatelessWidget {
  String month = '1';
  MotherChecklistPage({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('checklist')
          .doc(month)
          .collection('questions')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          print(month);
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData && snapshot.data!.docs.isEmpty) {
          print(snapshot.data);
          return const Center(child: Text('No checklist items found'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot questionDoc = snapshot.data!.docs[index];
            // Access the 'text' field from the question document
            String questionText = questionDoc['text'];
            ChecklistItem item =
                ChecklistItem.fromSnapshot(snapshot.data!.docs[index]);

            // Get the selected choice from the Firestore document
            String? selectedChoice = questionDoc['choice'];

            return ListTile(
              title: Text(questionText),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildChoiceButton(
                    text: 'Yes',
                    onPressed: () {
                      copyChecklistToMother('Yes',month);
                      _updateChoice(item.id, 'Yes');
                    },
                    isSelected: selectedChoice == 'Yes',
                  ),
                  _buildChoiceButton(
                    text: 'Maybe',
                    onPressed: () {
                      copyChecklistToMother('Maybe',month);
                      _updateChoice(item.id, 'Maybe');
                    },
                    isSelected: selectedChoice == 'Maybe',
                  ),
                  _buildChoiceButton(
                    text: 'No',
                    onPressed: () {
                      copyChecklistToMother('No',month);
                      _updateChoice(item.id, 'No');
                    },
                    isSelected: selectedChoice == 'No',
                  ),
                  _buildChoiceButton(
                    text: 'Reset',
                    onPressed: () {
                      copyChecklistToMother('',month);
                      _updateChoice(item.id, null);
                    },
                    isSelected: selectedChoice == null,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildChoiceButton({
    required String text,
    required VoidCallback onPressed,
    required bool isSelected,
  }) {
    Color buttonColor;

    switch (text) {
      case 'Yes':
        buttonColor = isSelected ? Colors.green : Colors.grey;
        break;
      case 'Maybe':
        buttonColor = isSelected ? Colors.orange : Colors.grey;
        break;
      case 'No':
        buttonColor = isSelected ? Colors.red : Colors.grey;
        break;
      case 'Reset':
        buttonColor = isSelected ? Colors.blue : Colors.grey;
        break;
      default:
        buttonColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  Future<void> _updateChoice(String itemId, String? choice) async {
    // Update the Firestore document with the selected choice
    await FirebaseFirestore.instance
        
        .collection('checklist')
        .doc(month)
        .collection('questions')
        .doc(itemId)
        .update({'choice': choice});
  }
}
