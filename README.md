<p align="center">
  <img src="docs/README_IMAGES/logo.png" alt="CodeTrack Logo" width="120"/>
</p>

<h1 align="center">CodeTrack – DSA Progress Tracker</h1>

<p align="center">
  <strong>A professional web application to track your Data Structures & Algorithms practice across LeetCode, GeeksforGeeks, and Codeforces.</strong>
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#tech-stack">Tech Stack</a> •
  <a href="#folder-structure">Structure</a> •
  <a href="#installation">Installation</a> •
  <a href="#database-setup">Database</a> •
  <a href="#screenshots">Screenshots</a> •
  <a href="#future-scope">Future Scope</a> •
  <a href="#contributing">Contributing</a> •
  <a href="#license">License</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Java-17%2B-orange?style=flat-square&logo=openjdk" alt="Java"/>
  <img src="https://img.shields.io/badge/MySQL-8.0-blue?style=flat-square&logo=mysql" alt="MySQL"/>
  <img src="https://img.shields.io/badge/Tomcat-10.x-yellow?style=flat-square&logo=apache-tomcat" alt="Tomcat"/>
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="License"/>
  <img src="https://img.shields.io/badge/Status-In%20Development-blueviolet?style=flat-square" alt="Status"/>
  <img src="https://img.shields.io/github/stars/sarthakbohra27/CodeTrack?style=flat-square" alt="Stars"/>
</p>

<p align="center">
  <img src="docs/README_IMAGES/banner.png" alt="CodeTrack Banner" width="100%"/>
</p>

---

## 📖 Description

**CodeTrack** is a full-stack web application designed to help students and competitive programmers systematically track their DSA practice. Whether you're grinding LeetCode for placements, solving GeeksforGeeks problems, or participating in Codeforces contests — CodeTrack keeps everything organized in one place.

Built with a clean **MVC architecture** using **Java Servlets, JSP, JDBC, and MySQL**, CodeTrack is designed from the ground up to be scalable, maintainable, and production-ready.

---

## ✨ Features

| Feature | Status |
|---|---|
| 🔐 User Registration & Login | ✅ Planned |
| ➕ Add Solved Questions | ✅ Planned |
| ✏️ Edit Questions | ✅ Planned |
| 🗑️ Delete Questions | ✅ Planned |
| 🔍 Search Questions | ✅ Planned |
| 🎯 Filter by Topic / Platform / Difficulty | ✅ Planned |
| 📊 Analytics Dashboard | ✅ Planned |
| 📝 Notes per Question | ✅ Planned |
| ⭐ Favorite Questions | ✅ Planned |
| 📈 Progress Tracking | ✅ Planned |
| 🌙 Dark/Light Theme Toggle | ✅ Planned |
| 📱 Responsive Design | ✅ Planned |

---

## 🛠️ Tech Stack

### Frontend
| Technology | Purpose |
|---|---|
| HTML5 | Markup & Semantic Structure |
| CSS3 | Styling & Animations |
| Vanilla JavaScript | Client-side Logic |
| Chart.js | Analytics Charts |
| Font Awesome | Icons |
| Google Fonts (Poppins) | Typography |

### Backend
| Technology | Purpose |
|---|---|
| Java 17+ | Core Language |
| Java Servlets | Request Handling (Controller) |
| JSP | View Layer (Templating) |
| JDBC | Database Connectivity |

### Database & Server
| Technology | Purpose |
|---|---|
| MySQL 8.0 | Relational Database |
| Apache Tomcat 10.x | Application Server |
| Maven | Build & Dependency Management |

---

## 📁 Folder Structure

```
CodeTrack/
│
├── .github/
│   └── workflows/
│       └── ci.yml                  # GitHub Actions CI pipeline
│
├── docs/                           # Project documentation
│   ├── screenshots/                # App screenshots
│   ├── diagrams/                   # Architecture & DB diagrams
│   ├── report/                     # Project report
│   └── README_IMAGES/              # Images used in README
│
├── database/                       # SQL scripts
│   ├── schema.sql                  # Table definitions
│   ├── sample_data.sql             # Seed/sample data
│   └── README.md                   # Database setup guide
│
├── src/
│   ├── main/java/com/codetrack/
│   │   ├── model/                  # POJOs / Entity classes
│   │   ├── dao/                    # Data Access Objects (JDBC)
│   │   ├── servlet/                # Java Servlets (Controllers)
│   │   ├── service/                # Business logic layer
│   │   ├── util/                   # Utility helpers
│   │   ├── filter/                 # Servlet Filters (Auth, etc.)
│   │   ├── listener/               # Context / Session Listeners
│   │   └── config/                 # Configuration classes
│   └── test/java/com/codetrack/    # Unit tests
│
├── webapp/                         # Web resources (served by Tomcat)
│   │
│   ├── css/                        # Stylesheets
│   │   ├── variables.css           # CSS custom properties
│   │   ├── global.css              # Global / reset styles
│   │   ├── navbar.css              # Navigation bar
│   │   ├── sidebar.css             # Sidebar component
│   │   ├── dashboard.css           # Dashboard layout
│   │   ├── auth.css                # Login / Register pages
│   │   ├── forms.css               # Form components
│   │   ├── analytics.css           # Analytics page
│   │   ├── profile.css             # Profile page
│   │   ├── responsive.css          # Media queries
│   │   └── animations.css          # Keyframe animations
│   │
│   ├── js/                         # JavaScript modules
│   │   ├── app.js                  # App entry point
│   │   ├── auth.js                 # Auth logic
│   │   ├── dashboard.js            # Dashboard interactions
│   │   ├── analytics.js            # Chart rendering
│   │   ├── validation.js           # Form validation
│   │   ├── search.js               # Search functionality
│   │   ├── filters.js              # Filter logic
│   │   ├── chart.js                # Chart.js configurations
│   │   └── theme.js                # Theme toggle
│   │
│   ├── images/                     # Static images
│   │
│   ├── assets/                     # Misc static assets
│   │
│   ├── components/                 # Reusable JSP fragments
│   │   ├── navbar.jsp
│   │   ├── sidebar.jsp
│   │   ├── footer.jsp
│   │   ├── header.jsp
│   │   └── loader.jsp
│   │
│   ├── pages/                      # Application JSP pages
│   │   ├── index.jsp               # Landing / Home page
│   │   ├── login.jsp               # Login page
│   │   ├── register.jsp            # Registration page
│   │   ├── dashboard.jsp           # Main dashboard
│   │   ├── questions.jsp           # Question list
│   │   ├── add-question.jsp        # Add new question
│   │   ├── edit-question.jsp       # Edit question
│   │   ├── analytics.jsp           # Analytics & charts
│   │   ├── profile.jsp             # User profile
│   │   ├── settings.jsp            # App settings
│   │   └── error.jsp               # Generic error page
│   │
│   ├── WEB-INF/
│   │   └── web.xml                 # Deployment descriptor
│   │
│   └── favicon.ico
│
├── test/                           # Integration / manual tests
│
├── .vscode/                        # VS Code workspace settings
│
├── .editorconfig                   # Editor formatting rules
├── .gitignore                      # Git ignore rules
├── CHANGELOG.md                    # Project changelog
├── CONTRIBUTING.md                 # Contribution guidelines
├── CODE_OF_CONDUCT.md              # Community standards
├── LICENSE                         # MIT License
├── README.md                       # Project overview
└── pom.xml                         # Maven build file
```

---

## 🚀 Installation

### Prerequisites

- Java JDK 17 or higher
- Apache Tomcat 10.x
- MySQL 8.0+
- Maven 3.8+
- Git

### Steps

**1. Clone the repository**
```bash
git clone https://github.com/sarthakbohra27/CodeTrack.git
cd CodeTrack
```

**2. Configure the database**
```bash
mysql -u root -p < database/schema.sql
mysql -u root -p codetrack < database/sample_data.sql
```

**3. Configure DB connection**

Edit `src/main/java/com/codetrack/config/DBConfig.java`:
```java
public static final String URL      = "jdbc:mysql://localhost:3306/codetrack";
public static final String USERNAME = "your_username";
public static final String PASSWORD = "your_password";
```

**4. Build the project**
```bash
mvn clean package
```

**5. Deploy to Tomcat**

Copy `target/CodeTrack.war` to your Tomcat `webapps/` directory and start Tomcat:
```bash
$CATALINA_HOME/bin/startup.sh
```

**6. Open in browser**
```
http://localhost:8080/CodeTrack
```

---

## 🗄️ Database Setup

Refer to [`database/README.md`](database/README.md) for detailed database setup instructions.

**ER Diagram:**

> `docs/diagrams/er-diagram.png` *(Coming soon)*

**Main Tables:**

| Table | Description |
|---|---|
| `users` | Registered user accounts |
| `questions` | Solved DSA questions |
| `topics` | DSA topics (Arrays, Trees, etc.) |
| `platforms` | Coding platforms (LeetCode, GFG, etc.) |
| `notes` | User notes per question |
| `favorites` | Bookmarked questions |

---

## 📸 Screenshots

> *Screenshots will be added once the UI is implemented.*

| Page | Preview |
|---|---|
| Dashboard | *(Coming Soon)* |
| Questions List | *(Coming Soon)* |
| Analytics | *(Coming Soon)* |
| Profile | *(Coming Soon)* |

---

## 🔮 Future Scope

- [ ] **LeetCode API Integration** – Auto-fetch solved problems
- [ ] **Coding Streaks** – Daily streak tracking like GitHub contributions
- [ ] **Contest Tracker** – Track Codeforces/LeetCode contest performance
- [ ] **AI Recommendations** – Suggest next problems based on weak topics
- [ ] **Export to PDF/CSV** – Download your progress report
- [ ] **Email Notifications** – Daily reminders & weekly summaries
- [ ] **OAuth Login** – Sign in with Google/GitHub
- [ ] **Public Profiles** – Share your progress publicly
- [ ] **Browser Extension** – Auto-log solved problems from LeetCode

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add some amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

Please read [`CONTRIBUTING.md`](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

---

## 👤 Author

**Sarthak Bohra**
- GitHub: [@sarthakbohra27](https://github.com/sarthakbohra27)

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/sarthakbohra27">Sarthak Bohra</a>
</p>
