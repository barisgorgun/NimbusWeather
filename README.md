# 🌤️ NimbusWeather

**SwiftUI · Clean Architecture · Modular SPM · MVVM · Async/Await · High Test Coverage**

NimbusWeather is a modern, production-quality iOS weather application built using **SwiftUI** and **Clean Architecture**, structured into modular **SPM packages** (Domain, Data, Presentation). This ensures scalability, testability, and clean separation of concerns.

The app consumes **OpenWeather One Call 3.0 API** and provides real-time current, hourly, and daily forecasts with a reactive and visually dynamic experience.

---

## 🧱 Project Architecture

This project is built using a **Modular Clean Architecture** approach, enforced by **Swift Package Manager (SPM)**. The separation into distinct modules guarantees: predictable data flow, independent compilation, and strict dependency boundaries.

| Module | Core Responsibility | Key Components |
| :--- | :--- | :--- |
| **NimbusWeatherDomain** | **Business Logic Core** | UseCases, Entities (FavoriteCity, Weather), Repository Protocols |
| **NimbusWeatherData** | **External Details** | Repository Implementations, Data Sources (Remote/Local), DTOs, Mappers |
| **NimbusWeather** | **Presentation Layer** | Views, ViewModels, UI Models, Coordinator (Flow Control) |

### Key Design Decisions

* **MVVM with State Management:** ViewModels are fully tested and manage UI state.
* **Coordinator Pattern:** Navigation flow is isolated from Views and ViewModels (implicit in the structure).
* **Dependency Inversion:** All upper layers depend on **protocols** defined in the Domain layer.
* **Actor-based Concurrency:** Used for thread-safe operations like image loading and caching, preventing data races.

---

## ✨ Features

* **Modularized using Swift Package Manager (SPM)**.
* **Clean Architecture** with isolated Domain/Data/Presentation layers.
* **Async/Await networking** with a testable API layer and DTO mapping.
* **Actor-based concurrency** for safe data handling (e.g., image loading and favorites storage).
* **Favorite cities** with persistent storage.
* **Dynamic backgrounds** that change based on weather conditions 🌦️.
* **Debounced search experience** for efficient API usage.
* **Theme & temperature unit settings** (Celsius/Fahrenheit).
* **High test coverage across all layers** (Domain, Data, Presentation).

---

## 🧪 Test Strategy

NimbusWeather is built with a **test-first mindset**, ensuring **High test coverage** across all modules.

### ✔ Core Isolation
All tests are isolated using **Mock/Stub** implementations for external dependencies (APIs, Storage, and Repository protocols).

### ✔ Test Scopes

* **Domain Layer:** UseCase logic, Error conversions, and Entity transformations.
* **Data Layer:** Mapper tests using real JSON fixtures, RemoteDataSource tests with mock API service, Repository tests for APIError → DomainError mapping, and Persistent favorites storage tests.
* **Presentation Layer:** ViewModel tests covering search debounce, error states, and complex data integration logic (Home, Favorites, etc.).
* **Concurrency:** Actor-based ImageLoader tests covering cache behavior, invalid data handling, and concurrent request deduplication.

---

## 🎨 UI & Experience

### 🌈 Dynamic Weather Backgrounds
The UI automatically changes its background based on the current weather conditions (e.g., sunny, cloudy, rainy, night-time conditions).

### 📱 Smooth UX Features
* Debounced search
* Animated transitions
* Clean and modern weather layouts
* System Light / Dark Mode support

---

## 🚀 Technologies Used

* **Swift 5.9**
* **SwiftUI**
* **async / await & Actors**
* **Combine**
* **Swift Package Manager (SPM)**
* **XCTest (Unit Tests)**
* **OpenWeather API**
* **CoreLocation / Geocoding**

---

## 📱 Screenshots

### 🎬 Home
<img src="./Assets/Screenshots/home.png" width="300"/>

### 📌 Saved Locations
<img src="./Assets/Screenshots/favoriteCities.png" width="300"/>

### 🔍 Search
<img src="./Assets/Screenshots/search.png" width="300"/>

### ⚙️ Settings
<img src="./Assets/Screenshots/settings.png" width="300"/>

---

## 🤝 Contributing & License

Pull requests and issues are welcome.

---

**Developer:** [Barış Görgün](https://github.com/barisgorgun)

[🇹🇷 Türkçe için tıklayın](README-tr.md)
