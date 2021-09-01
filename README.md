# eq_ed

A soft skill trainer for adolecents.

## Project Description

This project aims to create a mobile application game for adolescents to help improve their soft skills and provide educators with some insights around associated derived user data. Here, adolescents are defined as attending the final three years of high school or the first year of university, making them typically between 15 and 19 years old. Overall, the key objective lies in helping to service the demand for soft skill training. To this end, the games' design intends to ensure an enjoyable user experience for adolescents while providing meaningful feedback on their displayed soft skills. On a high level, users are presented with typical university and workplace scenarios via video, which require the application of soft skills. They are then asked to respond to the given scenario by choosing one of the suggested answers in a multiple-choice format and receive feedback on their displayed soft skills.

## UI Design 
<img src="CatchUpHome.png" alt="hi" class="inline" width="300"/>

## External Connections 
- Server Hosted on AWS 
- Firebase Auth 
- Firebase Cloud Firestore 
- Firebase Analytics 
- Firebase Hosting 
- Firebase Storage 

# Requirements 

* Xcode 12.3
* Android Studio 
* Git
* Python
* Flask
* Ruby
* iOS 9 device
* Internet connection 


## Common Setup
Clone the repo and install the dependencies. 
The application runs talking to 4 API endpoints and the database without any additional installations or setup required. 

**Step 1.1**: 
git clone (insert our git repo link here)

**Step 1.2**: 
Option 1: Open Runner.xcworkspace in Xcode and run the app on a simulator or device.
Option 2: Open eq_ed in Android Studion as Flutter App to run on iOS, Android and Chrome emulators. 

**Step 1.3**: 
Run by hitting `ctrl + R`

Python code for deploying onto compute node. The server runs a Flask app with 4 API endpoints:
"/scoreUser", "/getLevelEnd", "/getQuestionResponse" and "/initLevelForUser". See schemas
schema_scoreUser_post.json
schema_getLevelEnd_post.json
schema_getQuestionResponse_post.json and
schema_initLevelForUser_post.json for details.

**Step 2.1**: Clone the PythonServerCode directory into the compute node (e.g. EC2)

**Step 2.2**: Install dependencies with 
```bash 
pip install -r requirements.txt
```

**Step 2.3**: Run the app with 
```bash
python3 flask_app_main.py
```


## Installing the iOS App
The application can also be tested on most iOS devices. 

**Step 1**: Naviagte to the app store via [Testflight](https://testflight.apple.com/join/rc8lUsIS) 

**Step 2**: Download the TestFlight application via the above link 

**Step 3**: Download the CatchUp beta version via the above link, make sure automatic updates are enabled 
