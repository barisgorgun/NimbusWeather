# 🌤️ NimbusWeather

**SwiftUI · Clean Architecture · Modüler SPM · MVVM · Async/Await · Tam
Test Kapsamı**

NimbusWeather, **SwiftUI** ve **Clean Architecture** prensipleriyle inşa
edilmiş modern bir iOS hava durumu uygulamasıdır.
Proje mimarisi; Domain, Data ve Presentation olmak üzere **modüler SPM
paketlerine** ayrılmıştır. Bu yapı ölçeklenebilirlik, test edilebilirlik
ve sürdürülebilirlik sağlar.

Uygulama, **OpenWeather One Call 3.0 API** kullanarak güncel, saatlik ve
günlük hava durumu bilgilerini sunar.

------------------------------------------------------------------------

## ✨ Özellikler

-   **SwiftUI tabanlı modern UI**
-   **Clean Architecture** katmanlı yapı
-   **MVVM** ViewModel bazlı ekran mantığı
-   **SPM ile modüler proje yapısı**
-   **Actor tabanlı concurrency** (Görsel yükleme ve caching)
-   **Tam async/await destekli networking**
-   **Gelişmiş hata yönetimi ve mapper katmanı**
-   **Konuma göre hava durumu getirme**
-   **Favori şehirler** (UserDefaults ile lokal kayıt)
-   **Tema ve sıcaklık birimi ayarları**
-   **Yüksek test kapsama oranı:**
    -   Domain
    -   Data (Mapper, DTO, Repository, DataSource)
    -   Presentation (ViewModel testleri)

------------------------------------------------------------------------

## 🧱 Proje Mimarisi

    NimbusWeather/
     ├─ NimbusWeatherDomain/      # Entity, UseCase, Repository Protokolleri
     ├─ NimbusWeatherData/        # RemoteDataSource, Repository Impl, DTO, Mapper
     ├─ NimbusWeather/            # SwiftUI Presentation (ViewModel + View)
     └─ Tests/                    # Tüm modüller için unit testler

------------------------------------------------------------------------

## 🧪 Test Stratejisi

NimbusWeather **güçlü test mimarisi** ile geliştirilmiştir.

### ✔ Domain

-   UseCase testleri
-   Error mapping

### ✔ Data

-   Gerçek JSON dosyalarıyla mapper testleri
-   Mock APIService ile DataSource testleri
-   Repository error mapping testleri
-   Favori şehir storage testleri

### ✔ Presentation

-   SearchViewModel (debounce, error, state)
-   HomeViewModel
-   WeatherDetailViewModel
-   FavoritesViewModel
-   ImageLoaderActor testleri

------------------------------------------------------------------------

## 🚀 Kullanılan Teknolojiler

-   Swift 5.9
-   SwiftUI
-   Combine
-   async/await
-   Actors
-   Swift Package Manager
-   XCTest
-   OpenWeather API

------------------------------------------------------------------------

## 📱 Ekran Görüntüleri

*(Uygulama ekran görüntülerini buraya eklenecektir.)*

------------------------------------------------------------------------

## 🤝 Katkı ve Lisans

Pull request ve issue’lara açıktır.  

---

**Geliştirici:** [Barış Görgün](https://github.com/barisgorgun)

[🇬🇧 For English, click here](README.md)
