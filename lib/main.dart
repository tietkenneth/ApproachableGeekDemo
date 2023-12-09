import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Approachable Geek Demo Profile Page"),
    );
  }
}

class UserProfile {
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String description;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.description,
  });

  UserProfile.updateName({
    required String firstName,
    required String lastName,
    String? phoneNumber,
    String? email,
    String? description,
  }) : this(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber ?? "",
          email: email ?? "",
          description: description ?? "",
        );

  UserProfile.updatePhoneNumber({
    String? firstName,
    String? lastName,
    required String phoneNumber,
    String? email,
    String? description,
  }) : this(
          firstName: firstName ?? "",
          lastName: lastName ?? "",
          phoneNumber: phoneNumber,
          email: email ?? "",
          description: description ?? "",
        );

  UserProfile.updateEmail({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    required String email,
    String? description,
  }) : this(
          firstName: firstName ?? "",
          lastName: lastName ?? "",
          phoneNumber: phoneNumber ?? "",
          email: email,
          description: description ?? "",
        );
  UserProfile.updateDescription({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    required String description,
  }) : this(
          firstName: firstName ?? "",
          lastName: lastName ?? "",
          phoneNumber: phoneNumber ?? "",
          email: email ?? "",
          description: description,
        );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  UserProfile userProfile = UserProfile(
      firstName: "", lastName: "", phoneNumber: "", email: "", description: "");

  void updateProfile(UserProfile updatedProfile) {
    setState(() {
      userProfile = UserProfile(
        firstName: updatedProfile.firstName.isNotEmpty
            ? updatedProfile.firstName
            : userProfile.firstName,
        lastName: updatedProfile.lastName.isNotEmpty
            ? updatedProfile.lastName
            : userProfile.lastName,
        phoneNumber: updatedProfile.phoneNumber.isNotEmpty
            ? updatedProfile.phoneNumber
            : userProfile.phoneNumber,
        email: updatedProfile.email.isNotEmpty
            ? updatedProfile.email
            : userProfile.email,
        description: updatedProfile.description.isNotEmpty
            ? updatedProfile.description
            : userProfile.description,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Edit Profile',
                  style: TextStyle(
                    fontSize: 25.0,
                  )),
              SizedBox(height: 25.0),
              Text("[profile picture here]"),
              SizedBox(height: 25.0),
              TextFormField(
                  controller: firstNameController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                  onTap: () {
                    //firstNameController.text = userProfile.firstName;
                    //lastNameController.text = userProfile.lastName;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NamePage(
                          onUpdate: updateProfile,
                          firstNameController: firstNameController,
                          lastNameController: lastNameController,
                        ),
                      ),
                    );
                  }),
              TextFormField(
                controller: phoneNumberController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Phone",
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PhonePage(
                              onUpdate: updateProfile,
                              phoneNumberController: phoneNumberController,
                            )),
                  );
                },
              ),
              TextFormField(
                  controller: emailController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmailPage(
                                onUpdate: updateProfile,
                                emailController: emailController,
                              )),
                    );
                  }),
              TextFormField(
                  controller: descriptionController,
                  readOnly: true,
                  decoration:
                      InputDecoration(labelText: "Tell Us About Yourself"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DescriptionPage(
                              onUpdate: updateProfile,
                              descriptionController: descriptionController)),
                    );
                  }),
            ],
          ),
        ),
      );
    });
  }

  void updateFullName() {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;

    // Concatenate the first name and last name
    String fullName = '$firstName $lastName';

    // Set the concatenated full name to the third TextFormField
    fullNameController.text = fullName;
  }
}

class NamePage extends StatelessWidget {
  final Function(UserProfile) onUpdate;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  NamePage(
      {required this.onUpdate,
      required this.firstNameController,
      required this.lastNameController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start (left)
          children: [
            const Text("What's your name?"),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                        controller: firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(),
                        ))),
                const SizedBox(width: 10.0),
                Expanded(
                    child: TextField(
                        controller: lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(),
                        ))),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () {
                String firstName = firstNameController.text;
                String lastName = lastNameController.text;
                UserProfile userProfile = UserProfile.updateName(
                  firstName: firstName,
                  lastName: lastName,
                );
                onUpdate(userProfile);
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}

class PhonePage extends StatelessWidget {
  final Function(UserProfile) onUpdate;
  final TextEditingController phoneNumberController;

  PhonePage({required this.onUpdate, required this.phoneNumberController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("What's your phone number?"),
            TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Your Phone Number',
                  border: OutlineInputBorder(),
                )),
            SizedBox(height: 15.0),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () {
                String phoneNumber = phoneNumberController.text;
                UserProfile userProfile =
                    UserProfile.updatePhoneNumber(phoneNumber: phoneNumber);
                onUpdate(userProfile);
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailPage extends StatelessWidget {
  final Function(UserProfile) onUpdate;
  final TextEditingController emailController;
  EmailPage({required this.onUpdate, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("What's your email?"),
            TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Your email address',
                  border: OutlineInputBorder(),
                )),
            SizedBox(height: 15.0),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () {
                String email = emailController.text;
                UserProfile userProfile = UserProfile.updateEmail(email: email);
                onUpdate(userProfile);
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptionPage extends StatelessWidget {
  final Function(UserProfile) onUpdate;
  final TextEditingController descriptionController;

  DescriptionPage(
      {required this.onUpdate, required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("What type of passenger are you?"),
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Write a little bit about yourself',
                  border: OutlineInputBorder(),
                )),
            SizedBox(height: 15.0),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () {
                String description = descriptionController.text;
                UserProfile userProfile =
                    UserProfile.updateDescription(description: description);
                onUpdate(userProfile);
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
