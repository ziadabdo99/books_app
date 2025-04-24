# Flutter Book App

A mobile application for browsing and searching books from the Project Gutenberg library using the [Gutendex API](https://gutendex.com/). Built with Flutter and Clean Architecture.


## Features

- **Infinite Scroll Pagination**: Automatically loads more books as you scroll
- **Search Functionality**: Instant book search with API integration
- **Responsive UI**: Adapts to mobile/tablet screens and orientations
- **Expandable Summaries**: Collapsible text with "See More/See Less" toggle
- **Error Handling**: Graceful error states for network issues
- **Cached Images**: Efficient image loading with placeholder states

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ziadabdo99/books_app
Install dependencies

bash
flutter pub get
Run the app

bash
flutter run
Project Structure (Clean Architecture)
lib/
├── core/
│   ├── errors/       # Failure classes & exceptions
│   └── utils/        # Shared utilities
│
├── features/
│   └── book_list/
│       ├── data/             # Data layer
│       │   ├── datasources/  # API data sources
│       │   ├── models/       # Data models
│       │   └── repositories/ # Repository implementations
│       │
│       ├── domain/           # Domain layer
│       │   ├── entities/     # Business objects
│       │   └── repositories/ # Abstract repository contracts
│       │
│       └── presentation/     # Presentation layer
│           ├── bloc/         # State management
│           ├── pages/        # Screen widgets
│           └── widgets/      # Reusable components
│
└── injection_container.dart # Dependency injection setup
Technical Implementation
Packages Used
State Management: flutter_bloc (Cubit)

HTTP Client: http

Image Caching: cached_network_image

Infinite Scroll: Custom pagination implementation

Dependency Injection: get_it

Key Components
Bloc/Cubit:

BookListCubit handles pagination and search states

State management with BookListState hierarchy

API Integration:

Gutendex API communication via BookRemoteDataSource

Rate-limited requests (1 request/second)

Error Handling:

Network failure detection

Empty state UI components

Error message propagation

Configuration
The app uses the public Gutendex API with no authentication required:

dart
Base URL: https://gutendex.com
Endpoint: /books
Usage
Browse Books

Scroll vertically to load more books

Tap any book card to view details (if implemented)

Search Books

Tap the search icon in the app bar

Type your search query

Results update automatically



License
MIT License - See LICENSE for details

Task Requirements Compliance
This implementation fulfills all core requirements from the technical task specification, including:

Cubit state management ✅

Clean Architecture implementation ✅

Infinite scroll pagination ✅

Search functionality ✅

Responsive UI ✅




