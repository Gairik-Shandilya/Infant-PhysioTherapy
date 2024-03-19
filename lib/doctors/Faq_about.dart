
import 'package:flutter/material.dart';

class DoctorFAQ {
  // Define a list to store FAQ items
  List<Map<String, String>> _faqList = [
    {
      'question': 'How do I add items to the doctor\'s checklist?',
      'answer':
          'To add items to the checklist, simply type the checklist item in the provided text field and click the "Add" button.'
    },
    {
      'question': 'Can I view the checklist items for different months?',
      'answer':
          'Yes, you can select the month using numbered buttons and view the checklist items corresponding to that month.'
    },
    {
      'question': 'What happens when I mark an item\'s status?',
      'answer':
          'When you mark an item\'s status, it gets updated in real-time on the doctor\'s checklist. Additionally, the corresponding status is copied to the mother\'s checklist for the same month.'
    },
    {
      'question': 'Can I edit or delete checklist items after adding them?',
      'answer':
          'Currently, the app does not support editing or deleting checklist items after they are added. However, you can reset the status of an item by selecting the "Reset" option.'
    },
    {
      'question': 'How do I ensure the confidentiality of checklist data?',
      'answer':
          'Checklist data is securely stored using Firebase Firestore, ensuring that only authorized users (doctors) can access and modify the checklist items.'
    },
    {
      'question': 'What if I encounter issues while using the app?',
      'answer':
          'If you encounter any technical issues or have questions about using the app, you can reach out to technical support for assistance.'
    },
    {
      'question': 'Can I access the checklist from multiple devices?',
      'answer':
          'Yes, you can access the checklist from any device by logging in with your credentials. Your checklist data is synced across devices in real-time.'
    },
    {
      'question':
          'Are there plans to add additional features or functionalities to the app?',
      'answer':
          'Yes, the development team is continuously working on improving the app and adding new features based on user feedback and industry trends.'
    },
  ];

  // Method to generate a widget displaying all FAQs
}

class DoctorChecklistFAQ extends StatefulWidget {
  const DoctorChecklistFAQ({super.key});

  @override
  State<DoctorChecklistFAQ> createState() => _DoctorChecklistFAQState();
}

class _DoctorChecklistFAQState extends State<DoctorChecklistFAQ> {
  DoctorFAQ f1 = DoctorFAQ();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 89, 149),
        title: Text('FAQs'),
      ),
      body: ListView.builder(
        itemCount: f1._faqList.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(f1._faqList[index]['question']!),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(f1._faqList[index]['answer']!),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MotherFAQ {
  // Define a list to store FAQ items
  List<Map<String, String>> _faqList = [
    {
      'question': 'How do I add items to the doctor\'s checklist?',
      'answer':
          'To add items to the checklist, simply type the checklist item in the provided text field and click the "Add" button.'
    },
    {
      'question': 'Can I view the checklist items for different months?',
      'answer':
          'Yes, you can select the month using numbered buttons and view the checklist items corresponding to that month.'
    },
    {
      'question': 'What happens when I mark an item\'s status?',
      'answer':
          'When you mark an item\'s status, it gets updated in real-time on the doctor\'s checklist. Additionally, the corresponding status is copied to the mother\'s checklist for the same month.'
    },
    {
      'question': 'Can I edit or delete checklist items after adding them?',
      'answer':
          'Currently, the app does not support editing or deleting checklist items after they are added. However, you can reset the status of an item by selecting the "Reset" option.'
    },
    {
      'question': 'How do I ensure the confidentiality of checklist data?',
      'answer':
          'Checklist data is securely stored using Firebase Firestore, ensuring that only authorized users (doctors) can access and modify the checklist items.'
    },
    {
      'question': 'What if I encounter issues while using the app?',
      'answer':
          'If you encounter any technical issues or have questions about using the app, you can reach out to technical support for assistance.'
    },
    {
      'question': 'Can I access the checklist from multiple devices?',
      'answer':
          'Yes, you can access the checklist from any device by logging in with your credentials. Your checklist data is synced across devices in real-time.'
    },
    {
      'question':
          'Are there plans to add additional features or functionalities to the app?',
      'answer':
          'Yes, the development team is continuously working on improving the app and adding new features based on user feedback and industry trends.'
    },
  ];

  // Method to generate a widget displaying all FAQs
}

class MotherChecklistFAQ extends StatefulWidget {
  const MotherChecklistFAQ({super.key});

  @override
  State<MotherChecklistFAQ> createState() => _MotherChecklistFAQState();
}

class _MotherChecklistFAQState extends State<MotherChecklistFAQ> {
  MotherFAQ f1 = MotherFAQ();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 89, 149),
        title: Text('FAQs'),
      ),
      body: ListView.builder(
        itemCount: f1._faqList.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(f1._faqList[index]['question']!),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(f1._faqList[index]['answer']!),
              ),
            ],
          );
        },
      ),
    );
  }
}
