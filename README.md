# MindSpace 🌌

**Your personal sanctuary for emotional reflection and growth.**

MindSpace is a full-stack mental wellness mobile application designed to foster self-awareness and emotional processing. Built on the core philosophy of *"No advice. No judgment. Just a place to let it out,"* the platform provides users with a private, secure environment for audio-driven journaling, mood tracking, and authentic community connection. 

By prioritizing a frictionless user experience and preparing to leverage modern AI capabilities, MindSpace transcends traditional journaling—acting as a personal companion to help users uncover emotional patterns and reflect on their personal growth.

## 🌟 Core Features

**Currently Implemented:**
* **Secure Authentication:** Robust user sign-up and log-in architecture seamlessly connected to a cloud-based Supabase PostgreSQL database.
* **Persistent Sessions:** Secure local storage utilizing `shared_preferences` to keep users logged in across app launches for a frictionless experience.
* **Dynamic Dashboard:** A highly customized, time-aware UI that greets users based on the time of day and offers an intuitive mood-tracking interface.
* **Reflections Engine:** A dedicated history tab that dynamically fetches, filters, and displays past journal entries directly from the database, wrapped in a custom "Deep Twilight" calendar theme.
* **Premium UI/UX:** A thoughtfully crafted aesthetic featuring dark mode gradients, custom iconography, and smooth navigation transitions via `IndexedStack` and `GestureDetector`.

## 🚀 Upcoming Roadmap

* **Audio Journaling:** Native microphone integration allowing users to quickly record and save raw, unfiltered voice reflections.
* **AI Emotion Tracking:** Seamless integration with Google AI Studio to transcribe audio journals, detect dominant emotions, and provide users with actionable mental health insights.
* **Community Connection:** A secure, empathetic chat infrastructure designed to connect users seeking shared understanding and peer support.

## 🛠 Tech Stack

* **Frontend:** Flutter & Dart (Cross-platform mobile framework)
* **Backend:** FastAPI (High-performance Python web framework)
* **Database:** Supabase (PostgreSQL with built-in Auth and Row Level Security)

## 💻 Local Setup Instructions

### 1. Backend (FastAPI)
1. Open a terminal and navigate to your backend directory.
2. Create a `.env` file in the root of the backend directory containing your database credentials:
   ```env
   SUPABASE_URL=your_supabase_url
   SUPABASE_KEY=your_supabase_anon_key