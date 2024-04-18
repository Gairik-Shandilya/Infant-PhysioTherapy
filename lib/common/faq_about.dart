import 'package:flutter/material.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color.fromARGB(255, 16, 89, 149)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome to our healthcare app!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'At Infant Physiotherapy, we are dedicated to revolutionizing healthcare by leveraging cutting-edge technology to improve patient outcomes, enhance accessibility to healthcare services, and empower individuals to take control of their well-being.',
            ),
            SizedBox(height: 20),
            Text(
              'Who We Are',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We are a passionate team of healthcare professionals, technologists, and innovators committed to making a positive impact on the lives of people around the world. Our diverse backgrounds and expertise converge to create a dynamic environment where creativity, collaboration, and compassion thrive.',
            ),
            SizedBox(height: 20),
            Text(
              'What We Believe In',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Innovation: We believe in constantly pushing the boundaries of what\'s possible in healthcare through innovation and forward-thinking solutions.',
            ),
            Text(
              'Empowerment: We believe in empowering individuals to make informed decisions about their health and well-being, putting them at the center of their healthcare journey.',
            ),
            Text(
              'Accessibility: We believe that everyone deserves access to quality healthcare services, regardless of their background, location, or socioeconomic status.',
            ),
            Text(
              'Privacy and Security: We prioritize the privacy and security of our users\' data, implementing robust measures to safeguard sensitive information and ensure confidentiality.',
            ),
            SizedBox(height: 20),
            Text(
              'Our Commitment',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We are committed to delivering a seamless, user-friendly experience that meets the unique needs and preferences of our diverse community of users. Whether you\'re a patient, healthcare provider, or caregiver, we strive to exceed your expectations and provide the support you need to thrive.',
            ),
            SizedBox(height: 20),
            Text(
              'Get in Touch',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We value your feedback and input as we continue to improve and evolve our app. If you have any questions, suggestions, or just want to say hello, please don\'t hesitate to reach out to us. We\'re here for you every step of the way.',
            ),
            SizedBox(height: 20),
            Text(
              'Thank you for choosing Infant Physiotherapy. Together, let\'s build a healthier, happier world!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DoctorFAQ {
  // Define a list to store FAQ items
  final List<Map<String, String>> _faqList = [
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
        title: const Text('FAQs'),
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
  final List<Map<String, String>> _faqList = [
    {
      'question': 'How do I view the doctor\'s assessments for my child?',
      'answer':
          'You can view the assessments by selecting the appropriate month using the numbered buttons on the main screen.'
    },
    {
      'question': 'Is it possible to see progress over different months?',
      'answer':
          'Yes, you can select different months to see how your child\'s development compares over time.'
    },
    {
      'question': 'What does marking an item as "completed" mean?',
      'answer':
          'Marking an item as "completed" indicates that your child has achieved the milestone listed in the checklist for that month.'
    },
    {
      'question': 'Can I add notes or comments to the checklist?',
      'answer':
          'While the current version of the app does not support adding notes, you can provide feedback to the development team for future updates.'
    },
    {
      'question': 'How is my child\'s data protected?',
      'answer':
          'All data within the app is securely stored and managed with strict access controls to ensure that your information remains private and secure.'
    },
    {
      'question': 'What should I do if I find an error or have trouble using the app?',
      'answer':
          'Please contact our support team through the app\'s help section. We are here to assist you with any issues you encounter.'
    },
    {
      'question': 'Can I share my child\'s progress with other family members?',
      'answer':
          'Yes, the app provides an option to securely share your child\'s progress with family members or healthcare providers.'
    },
    {
      'question': 'Will there be new features added to help track my child\'s development?',
      'answer':
          'We regularly update the app with new features to enhance your experience and provide more comprehensive tracking of your child\'s development.'
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
        title: const Text('FAQs'),
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
