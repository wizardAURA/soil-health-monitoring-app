Soil Health Monitoring App
Welcome! This is a simple but powerful Flutter app designed to help you keep an eye on your soil's health. It's built to connect to a sensor, grab the latest temperature and moisture readings, and save them to a secure cloud backend. You can then view your data in real-time, either as a beautiful live chart or a detailed list of past reports.

What Can It Do?
Log In Securely: Your data is protected with a simple and secure email & password login system powered by Firebase.

Simulate a Real Sensor: Don't have the hardware? No problem! The app includes a mock Bluetooth service that generates realistic data, so you can test everything out.

See Live Data: Thanks to a real-time connection with a Firestore database, your data is always up-to-date. Any new reading you take will appear instantly.

Visualize Your Data: The home screen features a live-updating line chart, making it easy to spot trends in your soil's health at a glance.

View Detailed Reports: Need to see the numbers? A separate "Reports" screen lists all your past readings with exact timestamps.

Manage Your Data: Don't need an old report? Just swipe it away to delete it from the database.

Built on a Solid Foundation: The app uses the BLoC (Cubit) pattern for clean, predictable, and scalable state management.

Built With
Framework: Flutter

Language: Dart

Backend: Firebase (Authentication & Cloud Firestore)

State Management: flutter_bloc

Data Visualization: syncfusion_flutter_charts

Getting Started
Ready to run the app yourself? Here’s everything you need to get the project set up on your machine.

What You'll Need
The Flutter SDK (latest stable version is best).

A code editor you like (like VS Code or Android Studio).

An Android Emulator or a physical Android device to run the app on.

Step-by-Step Setup
Get the Code
First, you'll want to clone the repository to your local machine.

git clone <your-repository-url>
cd soil_health_monitoring_app

Set Up Your Firebase Project
This is where your app's data will live.

Head over to the Firebase Console.

Click "Add project" and give it a name.

Once your project is ready, click the Android icon to add an Android app.

For the Android package name, you can use com.example.soil_health_monitoring_app.

Download the google-services.json file that Firebase gives you and place it inside the android/app/ folder in your project.

Switch on the Firebase Services

In the Firebase Console, find the Authentication section. Click "Get Started" and enable the Email/Password sign-in option.

Next, go to the Firestore Database section. Click "Create database," choose to start in test mode, and select a cloud server location (like asia-south1 if you're in India).

Install the Project Dependencies

Open a terminal in the project's root folder and run:

flutter pub get

Run the App!

Make sure your Android emulator is running or your device is plugged in.

In your terminal, run:

flutter run

A Note on the Bluetooth Feature
It's a Simulation! This app doesn't connect to a real Bluetooth device. Instead, I created a mocked BluetoothService that generates random data. This was done to focus on building a solid app architecture (UI, state management, backend) without needing physical hardware. The service is designed so that a real Bluetooth implementation could be easily swapped in later with minimal fuss.

What You Get
Source Code: All the code is available in this repository.

A Ready-to-Install APK: To build your own release APK, just run the command below. You'll find the finished file in build/app/outputs/flutter-apk/app-release.apk.

flutter build apk --release
