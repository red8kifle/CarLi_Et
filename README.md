# CarLi_Et – Career Link Ethiopia

##  Professional Internship Management Application for Ethiopian University Students

---

##  Overview
CarLi_Et (Career Link Ethiopia) is a mobile application designed to simplify and digitize the internship process for Ethiopian university students.  

The platform connects students with organizations and provides a structured system to manage internship applications, track progress, and handle evaluations all in one place.

---

##  Goal
The goal of CarLi_Et is to:

- Bridge the gap between students and organizations  
- Simplify internship application and management processes  
- Provide a centralized and transparent system  
- Ensure a more organized, efficient, and fair internship experience  

---

##  Project Description
CarLi_Et serves as a central hub where:

- Students can discover and apply for internships  
- Organizations can post opportunities and manage applicants  
- Both parties can track progress and receive updates  

>  The system is designed to run locally, making it lightweight and suitable for controlled environments such as university systems.

---

##  Team Members

| Name               | ID            |
|--------------------|---------------|
| Hayat Abdulkerim   | UGR/0826/16   |
| Rediet Kifle       | UGR/8926/16   |
| Hanna Alemyehu     | UGR/2795/16   |
| Yanet Abrham       | UGR/0385/16   |
| Kaleab Lemma       | UGR/2941/16   |

---

##  Features

### 1. Authentication & Authorization
- Secure user registration and login  
- University-based credential validation (using university email)  
- Role-based access:
  - **Students** - Apply & track internships  
  - **Organizations** - Post & manage internships  
- Token-based authentication via REST API  

---

### 2. User Profile Management (CRUD)
Users can:
- Create and manage their profiles  
- Update personal and academic information (skills, interests, experience)  
- View profile details  
- Delete their account  

---

### 3. Internship Management System (CRUD)

####  For Students:
- Browse available internships  
- Apply to internships  
- Track application status  
- View internship details  

####  For Organizations:
- Create and post internship opportunities  
- View applicants for each internship  
- Access student resumes  
- Update internship details  
- Delete outdated postings  

---

### 4.  Notification System
- Students receive updates on application status (accepted/rejected)  
- Organizations are notified when students apply  
- Real-time communication between both parties  

---

##  Backend Responsibilities (REST API)

The backend system handles:

- User authentication and authorization  
- Profile creation and updates  
- Internship listings (storage & retrieval)  
- Internship application processing  
- Application status management (pending, accepted, rejected)  
- Notification logic  
- Secure role-based access control  
- Local database management  

---

##  Important Notes

- Runs on **localhost only**  
- No external hosting or cloud services  
- No Firebase / Firestore used  

---

##  Technologies Used

- **Frontend:** Flutter  
- **Backend:** Node.js / Express (REST API)  
- **Database:** Local database  

---

##  Testing Strategy

- **Unit Testing** - Validate business logic  
- **Widget Testing** - Ensure UI components work correctly  
- **Integration Testing** - Test complete workflows  

---

## Setup Instructions

### Prerequisites
- Flutter SDK (3.0+)
- Node.js (18+)
- Android Studio / VS Code (for mobile)

---

## Quick Setup

### 1. Backend Setup

```bash
cd backend
npm install
npm run dev

Keep this terminal running!

### 2. Flutter Setup (New Terminal)

```bash
cd ..
flutter pub get
flutter run

## Platform Options

| Platform | Command |
|----------|---------|
| Chrome (Web) | `flutter run -d chrome` |
| Android Emulator | `flutter run -d android` |
| Physical Phone | `adb reverse tcp:3000 tcp:3000` then `flutter run` |

---

## Physical Phone Setup

1. Enable USB Debugging on phone
2. Connect via USB
3. Run: `adb reverse tcp:3000 tcp:3000`
4. Run: `flutter run`