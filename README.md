# 🌤️ NimbusWeather

**SwiftUI · Clean Architecture · Modular SPM · MVVM · Async/Await · Full
Test Coverage**

NimbusWeather is a modern iOS weather application built with **SwiftUI**
and **Clean Architecture**, structured into modular **SPM packages**
(Domain, Data, Presentation) to ensure scalability, testability, and
maintainability.

The app uses **OpenWeather One Call 3.0 API** to deliver precise
current, hourly, and daily forecasts with a fully responsive UI.

------------------------------------------------------------------------

## ✨ Features

-   **SwiftUI-based UI** with declarative and reactive design
-   **Clean Architecture** with Domain/Data/Presentation separation
-   **MVVM** pattern with fully tested ViewModels
-   **Modular project** using Swift Package Manager
-   **Actor-based concurrency** (Image loading, caching)
-   **Full async/await networking**
-   **Advanced error handling** and mapper layer
-   **Location-based weather fetching**
-   **Favorites system** with local persistence (UserDefaults)
-   **Theme and temperature unit settings**
-   **High test coverage:**
    -   Domain layer
    -   Data layer (DTO, Mapper, Repository, DataSource)
    -   Presentation layer (ViewModels)

------------------------------------------------------------------------

## 🧱 Project Architecture

    NimbusWeather/
     ├─ NimbusWeatherDomain/      # Entities, UseCases, Repository Interfaces
     ├─ NimbusWeatherData/        # Remote Data Source, Repository Impl, DTOs, Mappers
     ├─ NimbusWeather/            # SwiftUI Presentation Layer (ViewModels, Views)
     └─ Tests/                    # Full unit test coverage for all modules

------------------------------------------------------------------------

## 🧪 Test Strategy

NimbusWeather provides **high test reliability** through:

### ✔ Domain Layer

-   UseCase logic
-   Entities
-   Error mapping

### ✔ Data Layer

-   All mappers tested with real JSON fixtures
-   RemoteDataSource mocked with custom APIService
-   Repository tests with APIError → DomainError mapping
-   Persistence tests (FavoriteCityStorage)

### ✔ Presentation Layer

-   ViewModel tests (Search, Home, Detail, Favorites)
-   Debounce, error handling, state management tests

------------------------------------------------------------------------

## 🚀 Technologies Used

-   Swift 5.9
-   SwiftUI
-   Combine
-   async/await
-   Actors
-   SPM modularization
-   XCTest
-   OpenWeather API

------------------------------------------------------------------------

## 📱 Screenshots

*Will be added images*

------------------------------------------------------------------------

## 🤝 Contributing & License

Pull requests and issues are welcome.  

---

**Developer:** [Barış Görgün](https://github.com/barisgorgun)

[🇹🇷 Türkçe için tıklayın](README.tr.md)
