# SkillBazaar - Learning Management System

SkillBazaar is a role-based Learning Management System developed using Java, JSP, Servlets, JDBC, MySQL and Bootstrap.

## Features

### Student
- Student registration and login
- Browse available courses
- Course enrollment
- Payment status tracking
- Enrollment approval/rejection workflow
- Access course content after successful payment and approval
- Video progress tracking

### Instructor
- Instructor login
- Add courses
- Add course videos
- Manage course videos
- View enrolled students

### Admin
- Admin login
- View courses
- Approve pending courses
- View pending enrollments
- Approve or reject enrollments
- Delete courses

## Technology Stack

- Java
- JSP
- Servlets
- JDBC
- MySQL
- HTML5 / CSS3
- Bootstrap
- Apache Tomcat 9
- Eclipse IDE

## Project Structure

```text
SkillBazaar/
├── src/main/java/com/skillbazaar/
│   ├── admin/
│   ├── auth/
│   ├── dao/
│   ├── instructor/
│   ├── payment/
│   └── student/
├── src/main/webapp/
│   ├── admin/
│   ├── instructor/
│   ├── student/
│   └── WEB-INF/
├── database/
│   └── skillbazaar_schema.sql
├── .env.example
├── .gitignore
└── README.md
```

## Requirements

- JDK 8 or compatible Java version used by the project
- Apache Tomcat 9.x
- MySQL 8.x
- Eclipse IDE (Dynamic Web Project / Web Tools Platform)

## Database Setup

1. Start MySQL.
2. Create the database:

```sql
CREATE DATABASE skillbazaar;
```

3. Run `database/skillbazaar_schema.sql` in MySQL Workbench.
4. Set the environment variables described below.
5. Import the project into Eclipse and run it on Tomcat.

The repository intentionally contains **schema only**. It does not contain real user passwords, payment records, transaction references, or other private database data.

## Environment Variables

The application does not store database or admin credentials in the source code.

Copy `.env.example` as a reference and configure these variables in your operating system / Tomcat environment:

```text
SKILLBAZAAR_DB_URL=jdbc:mysql://localhost:3306/skillbazaar?useSSL=false&serverTimezone=UTC
SKILLBAZAAR_DB_USERNAME=root
SKILLBAZAAR_DB_PASSWORD=your_mysql_password
SKILLBAZAAR_ADMIN_USERNAME=admin
SKILLBAZAAR_ADMIN_PASSWORD=your_admin_password
```

On Windows, you can configure them through **System Properties → Environment Variables**. Restart Eclipse/Tomcat after adding or changing them.

> Never commit your real password or a local `.env` file to GitHub.

## Running the Project

1. Clone/download the repository.
2. Import `SkillBazaar` as an existing Eclipse Dynamic Web Project.
3. Configure the environment variables.
4. Make sure MySQL is running and the `skillbazaar` schema has been created.
5. Add the project to Apache Tomcat 9.
6. Start Tomcat.
7. Open the application through the Tomcat URL shown by Eclipse.

## Security Note

This is an academic/internship project. The public repository has been cleaned of real credentials and private database records. For a production system, passwords should also be stored using a strong one-way password hashing algorithm rather than plain text.

## Author

Siddhi Pathade
