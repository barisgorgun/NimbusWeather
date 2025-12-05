# 🌤️ NimbusWeather

**SwiftUI · Clean Architecture · Modular SPM · MVVM · Async/Await · High
Test Coverage**

NimbusWeather is a modern, production-quality iOS weather application
built using **SwiftUI** and **Clean Architecture**, structured into
modular **SPM packages** (Domain, Data, Presentation). This ensures
scalability, testability, and clean separation of concerns.

The app consumes **OpenWeather One Call 3.0 API** and provides real-time
current, hourly, and daily forecasts with a reactive and visually
dynamic experience.

------------------------------------------------------------------------

## ✨ Features

-   **SwiftUI-based reactive interface**
-   **Clean Architecture** with isolated Domain/Data/Presentation
    layers\
-   **MVVM with fully tested ViewModels**
-   **Modularized using Swift Package Manager (SPM)**
-   **Actor-based concurrency** for safe image loading and caching
-   **Async/Await networking**, testable API layer, and DTO mapping
-   **Location-based weather fetching** (reverse geocoding included)
-   **Favorite cities** with persistent storage
-   **Theme & temperature unit settings** (Celsius/Fahrenheit)
-   **Dynamic backgrounds that change based on weather conditions** 🌦️
-   **System Light / Dark Mode support**
-   **Debounced search experience** for efficient API usage
-   **High test coverage across all layers** (Domain, Data,
    Presentation)

------------------------------------------------------------------------

## 🧱 Project Architecture

    NimbusWeather/
     ├─ NimbusWeatherDomain/      # Entities, UseCases, Repository Interfaces
     ├─ NimbusWeatherData/        # Remote Data Source, Repository Impl, DTOs, Mappers
     ├─ NimbusWeather/            # SwiftUI Presentation Layer (Views, ViewModels, UI Models)
     └─ Tests/                    # Full unit test coverage for all modules

This architecture ensures:

-   Testability of each module
-   Independent compilation and maintenance
-   Predictable data flow
-   Clean dependency boundaries

------------------------------------------------------------------------

## 🧪 Test Strategy

NimbusWeather is built with a **test-first mindset**, including:

### ✔ Domain Layer

-   UseCase logic
-   Error conversions
-   Entity transformations

### ✔ Data Layer

-   Mapper tests using real JSON fixtures
-   RemoteDataSource tests with mock API service
-   Repository tests for APIError → DomainError mapping
-   Persistent favorites storage tests

### ✔ Presentation Layer

-   ViewModel tests for:
    -   Search (debounce, error states, mapping)
    -   Home (location + weather integration)
    -   Weather Detail
    -   Favorite City List
-   Actor-based ImageLoader tests:
    -   Cache behavior
    -   Invalid data handling
    -   Concurrent request deduplication

------------------------------------------------------------------------

## 🎨 UI & Experience

### 🌈 Dynamic Weather Backgrounds

The UI automatically changes its background based on the current weather
conditions
(e.g., sunny, cloudy, rainy, night-time conditions).

### 🌗 Light & Dark Mode Support

NimbusWeather adapts seamlessly to the user's system appearance.

### 📱 Smooth UX Features

-   Debounced search
-   Animated transitions
-   Clean and modern weather layouts

------------------------------------------------------------------------

## 🚀 Technologies Used

-   Swift 5.9
-   SwiftUI
-   Combine
-   async / await
-   Actors
-   XCTest (Unit Tests)
-   Swift Package Manager
-   OpenWeather API
-   CoreLocation / Geocoding

------------------------------------------------------------------------

## 📱 Screenshots

### 🎬 Home
<img src="./Assets/Screenshots/home.png" width="300"/>

### 📌 Saved Locations
<img src="./Assets/Screenshots/favoriteCities.png" width="300"/>

### 🔍 Search
<img src="./Assets/Screenshots/search.png" width="300"/>

### ⚙️ Settings
<img src="./Assets/Screenshots/settings.png" width="300"/>
```

---
------------------------------------------------------------------------

## 🤝 Contributing & License

Pull requests and issues are welcome.  

---

**Developer:** [Barış Görgün](https://github.com/barisgorgun)

[🇹🇷 Türkçe için tıklayın](README-tr.md)
