import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChecklistItem {
  String id;
  String text;
  bool completed;

  ChecklistItem({
    required this.id,
    required this.text,
    required this.completed,
  });

  factory ChecklistItem.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ChecklistItem(
      id: snapshot.id,
      text: data['text'] ?? '',
      completed: data['completed'] ?? false,
    );
  }
}

class DoctorChecklistPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _addItemController = TextEditingController();

  Future<void> _addItem() async {
    User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;

      await FirebaseFirestore.instance.collection('checklist').add({
        'doctorId': userId,
        'text': _addItemController.text,
        'completed': false,
      });

      _addItemController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          SizedBox(height: 20,),
        Text(
                  'Doctor Checklist',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4A545E),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
        SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _addItemController,
                    decoration: InputDecoration(
                      hintText: 'Add checklist item...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addItem,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('checklist')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.data == null ||
                    snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No checklist items found'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    ChecklistItem item =
                        ChecklistItem.fromSnapshot(snapshot.data!.docs[index]);

                    return ListTile(
                      title: Text(item.text),
                      trailing: Checkbox(
                        value: item.completed,
                        onChanged: (value) {
                          FirebaseFirestore.instance
                              .collection('checklist')
                              .doc(item.id)
                              .update({'completed': value});
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MotherChecklistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('checklist').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No checklist items found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              ChecklistItem item =
                  ChecklistItem.fromSnapshot(snapshot.data!.docs[index]);

              return ListTile(
  title: Text(item.text),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Checkbox(
        value: item.completed,
        onChanged: (value) {
          // Update the Firestore document when the checkbox is changed
          FirebaseFirestore.instance
              .collection('checklist')
              .doc(item.id)
              .update({'completed': value});
        },
      ),
      IconButton(
        icon: item.completed ? Icon(Icons.clear) : Icon(Icons.check),
        onPressed: () {
          // Update the Firestore document to mark as incomplete (false) or complete (true)
          FirebaseFirestore.instance
              .collection('checklist')
              .doc(item.id)
              .update({'completed': !item.completed});
        },
      ),
    ],
  ),
);


            },
          );
        },
      
    );
  }
}

