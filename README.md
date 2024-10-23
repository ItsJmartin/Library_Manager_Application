# library_management_app


Library Management App


This app allows users to manage books, authors, and members in a library system with an intuitive UI and smooth navigation. The app is developed using Flutter and is structured to ensure a user-friendly experience for book collection management.

Features
Landing Page: A simple homepage where users can select from three categories: Books, Authors, and Members.
Book Management: Users can search, add, edit, and delete books. The page provides real-time search functionality, along with a secure book vault to keep track of the collection.
Author Management: A dedicated section for viewing and exploring authors from various genres and fields.
Member Management: Users can manage community members who contribute to the library, fostering a love for literature and learning.
Floating Action Button (FAB): Quickly navigate to add books and manage library content using a floating button that appears on the relevant pages.
UI/UX: The app features a clean, modern design with responsive layouts, enhanced by the use of shadows, gradients, and animations to improve usability.
Pages

1. Landing Page

The landing page serves as the starting point for the app, allowing users to choose between managing books, authors, or members.

Books Section: Displays a card for book management with a "Books" label and a background image representing a collection of books.
Authors Section: Displays a card for authors management with an "Authors" label and a background image representing authors.
Members Section: Displays a card for managing members with a "Members" label and an image representing the community of readers.
Each section uses a GestureDetector to handle taps and navigates to the respective pages via the Flutter Navigator.

2. Book Management Page

This page provides a streamlined way to manage books within the library.

Search Functionality: Users can search for books by typing in a search field. As they type, search results are dynamically updated in real-time, showing book covers, titles, and authors.
Book List: All books in the collection are listed with their cover images, titles, and authors.
Add, Edit, Delete Books: Users can:
Add books by clicking the floating action button, which opens a dialog for adding new book details.
Edit existing book details using the "Edit" button next to each book.
Delete books with a delete icon, which triggers a confirmation dialog.
Secure Book Vault: A locked vault symbol at the end of the book list encourages users to add more books to the library.
Design:
The page uses a background image for visual appeal, which is blurred using a BackdropFilter to maintain focus on the book content.
Book details and search results are styled using GoogleFonts for a professional look.
The floating action button is customized with a green background and white border to match the overall app theme.
3. Author Management Page

This page provides an overview of authors in the system. The card displays the list of authors and allows users to view detailed information about each author’s work and contributions.

4. Member Management Page

The members' section highlights the library community. It offers features to manage members who are part of the library’s reader community, allowing for an interactive and inclusive reading experience.

Design Elements
Custom Fonts: The app uses GoogleFonts to customize the typography for a clean, modern look across all pages. Fonts like Nunito and Bodoni Moda give the app a professional, easy-to-read design.
Blurred Background: A blurred background overlay adds a stylish effect to the pages, allowing the main content to stand out while maintaining visual aesthetics.
Shadow Effects: Cards and containers use shadow effects (BoxShadow) to create depth and give a polished, layered appearance to the UI.
Responsiveness: The layout adjusts to different screen sizes, ensuring a smooth experience on both mobile and tablet devices.
Technologies Used
Flutter: The framework used to build the app, enabling cross-platform functionality.
Google Fonts: Custom fonts to enhance the app’s visual appeal.
State Management: Use of controllers to manage the state of the book search and book list.
JSON: The data is stored locally in JSON format, making it easy to manage and persist the book, author, and member data.
How to Run the App
Clone the repository:

bash
Copy code
git clone <https://github.com/ItsJmartin/Library_Manager_Application>


Navigate into the project directory:
  cupertino_icons: ^1.0.6
  google_fonts: ^6.2.1
  path_provider: ^2.1.4


bash
Copy code
cd library_management_app
Install dependencies:

arduino
Copy code
flutter pub get
Run the app:

arduino
Copy code
flutter run
Make sure you have Flutter installed on your machine, along with an emulator or a connected device.

App Architecture

LandingPage: Acts as the entry point for selecting the desired management section (Books, Authors, Members).

BookPage: Manages book-related operations like searching, adding, editing, and deleting books.
AuthorPage: Provides author-related functionalities.
MemberPage: Handles the management of library members.
Future Improvements

Backend Integration: Currently, the app uses local JSON storage. Future updates could integrate a backend to allow for real-time synchronization and cloud storage.

Advanced Search: Add filters and sorting options to enhance the book search experience.
User Authentication: Implement user login and profile management for a personalized experience.

project not published yet.... under development.