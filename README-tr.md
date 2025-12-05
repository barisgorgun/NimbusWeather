# 🌤️ NimbusWeather

**SwiftUI · Clean Architecture · Modüler SPM · MVVM · Async/Await ·
Yüksek Test Kapsamı**

NimbusWeather, **SwiftUI** ve **Clean Architecture** prensipleriyle
geliştirilmiş modern bir iOS hava durumu uygulamasıdır.
Proje yapısı; Domain, Data ve Presentation olmak üzere **SPM ile
modüler** şekilde ayrılmıştır. Bu sayede proje kolayca ölçeklenebilir,
test edilebilir ve bakımı uzun vadede oldukça rahattır.

Uygulama, **OpenWeather One Call 3.0 API** kullanarak güncel, saatlik ve
günlük hava durumu verilerini sunar.

------------------------------------------------------------------------

## ✨ Özellikler

-   **SwiftUI tabanlı modern arayüz**
-   **Clean Architecture** katmanlı mimari
-   **Tamamen test edinilebilir MVVM ViewModel yapıları**
-   **SPM ile modüler proje mimarisi**
-   **Actor tabanlı concurrency** (Görsel yükleme, caching)
-   **Tam async/await destekli networking katmanı**
-   **Gelişmiş hata yönetimi ve mapper katmanı**
-   **Konuma dayalı hava durumu sorgulama**
-   **Favori şehirler sistemi** (UserDefaults ile kalıcı kayıt)
-   **Tema ve sıcaklık birimi ayarları (Celsius / Fahrenheit)**
-   **Hava durumuna göre değişen dinamik arka planlar** 🌦️
-   **Light / Dark Mode desteği**
-   **Debounce mekanizmalı performanslı arama**
-   **Tüm katmanlar için kapsamlı testler** (Domain, Data, Presentation)

------------------------------------------------------------------------

## 🧱 Proje Mimarisi

    NimbusWeather/
     ├─ NimbusWeatherDomain/      # Entity, UseCase, Repository protokolleri
     ├─ NimbusWeatherData/        # DataSource, Repository Impl, DTO, Mapper
     ├─ NimbusWeather/            # SwiftUI View, ViewModel ve UI modelleri
     └─ Tests/                    # Modüllerin tamamı için unit testler

Bu yapı sayesinde:

-   Test izolasyonu sağlanır
-   Kod bağımlılıkları kontrol altında tutulur
-   Modüller bağımsız geliştirilebilir
-   Uzun vadede sürdürülebilir bir mimari oluşur

------------------------------------------------------------------------

## 🧪 Test Stratejisi

NimbusWeather **test odaklı** tasarlanmıştır.

### ✔ Domain

-   UseCase iş mantığı
-   Error dönüşümleri

### ✔ Data

-   Gerçek JSON dosyalarıyla mapper testleri
-   Mock APIService ile DataSource testleri
-   Repository error mapping testleri
-   Favori şehir storage testleri

### ✔ Presentation

-   SearchViewModel (debounce, hata, state)
-   HomeViewModel (konum + hava durumu)
-   WeatherDetailViewModel
-   LocationListViewModel
-   ImageLoaderActor testleri
    -   Cache davranışı
    -   Hatalı data testi
    -   Concurrent çağrıların tek seferde işlenmesi

------------------------------------------------------------------------

## 🎨 Arayüz & Deneyim

### 🌈 Hava Durumuna Göre Dinamik Arka Planlar

Güncel hava durumuna göre arka plan otomatik değişir
(güneşli, yağmurlu, bulutlu, gece teması vb.)

### 🌗 Light / Dark Mode Desteği

Uygulama sistem temasına göre otomatik uyum sağlar.

### 📱 Modern Kullanıcı Deneyimi

-   Debounce'lu arama
-   Akıcı animasyonlar
-   Temiz ve modern hava durumu kartları

------------------------------------------------------------------------

## 🚀 Kullanılan Teknolojiler

-   Swift 5.9
-   SwiftUI
-   Combine
-   async / await
-   Actors
-   XCTest
-   Swift Package Manager
-   OpenWeather API
-   CoreLocation / Geocoding

------------------------------------------------------------------------

## 📱 Ekran Görüntüleri

### 🎬 Ana Sayfa
<img src="./Assets/Screenshots/home.png" width="300"/>

### 📌 Favori Şehirler
<img src="./Assets/Screenshots/favoriteCities.png" width="300"/>

### 🔍 Arama
<img src="./Assets/Screenshots/search.png" width="300"/>

### ⚙️ Ayarlar
<img src="./Assets/Screenshots/settings.png" width="300"/>
```

---
------------------------------------------------------------------------

## 🤝 Katkı ve Lisans

Pull request ve issue’lara açıktır.  

---

**Geliştirici:** [Barış Görgün](https://github.com/barisgorgun)

[🇬🇧 For English, click here](README.md)
