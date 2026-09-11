# MindSpace

A full-stack mobile application designed to provide a safe space for emotional reflection, journaling, and community connection. No advice. No judgment. Just a place to let it out.

## Features

**Currently Implemented:**
*   **Secure Authentication:** User sign-up and log-in seamlessly connected to a cloud database.
*   **Persistent Sessions:** Secure local storage using `shared_preferences` to keep users logged in.
*   **Dynamic Dashboard:** Time-aware greetings and an intuitive mood-tracking UI.
*   **Journal History:** A Reflections tab that dynamically fetches and displays past journal entries directly from the database.
*   **Custom UI Elements:** Deep twilight aesthetic with tailored date pickers and smooth navigation transitions.

**Upcoming Features:**
*   **Audio Journaling:** Native microphone integration to record and save voice reflections.
*   **AI Emotion Tracking:** Integration with Google AI Studio to transcribe audio journals and detect dominant emotions.
*   **Community Connection:** Secure chat infrastructure to connect with other users.

## Tech Stack

*   **Frontend:** Flutter & Dart
*   **Backend:** FastAPI (Python)
*   **Database:** Supabase (PostgreSQL)

## Screenshots

| Sign Up & Log In | Home Dashboard | My Reflections |
| :---: | :---: | :---: |
| <img src="assets/screenshots/login.png" width="220" /> | <img src="assets/screenshots/home.png" width="220" /> | <img src="assets/screenshots/reflections.png" width="220" /> |

## Local Setup Instructions

### 1. Backend (FastAPI)
1. Open a terminal and navigate to the backend directory.
2. Create a `.env` file containing your database credentials:
   ```env
   SUPABASE_URL=your_supabase_url
   SUPABASE_KEY=your_supabase_anon_key