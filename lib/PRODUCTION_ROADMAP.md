# 🏥 MediMo — Production Roadmap

> Чек-лист технологий и шагов для вывода приложения на production уровень.
> Порядок важен: каждый этап является фундаментом для следующего.

---

## Текущее состояние проекта (анализ на 30.04.2026)

**Что уже есть:**
- ✅ Базовая Feature-First структура папок (`features/user_greeting/`)
- ✅ Слои `data/`, `domain/`, `presentation/` созданы (но пока пустые)
- ✅ Кастомная тема (`AppTheme`, `AppColors`) в `core/theme/`
- ✅ Экраны: Greeting, Onboarding (2 шага), Login, Registration, ForgotPassword, VerificationCode, ResetPassword
- ✅ Сплэш-скрин (`flutter_native_splash`)

**Что отсутствует и требует внедрения:**
- ❌ State Management (нет ни одного провайдера/блока)
- ❌ Роутинг (голый `Navigator.push` с прямыми ссылками на классы)
- ❌ DI (Dependency Injection)
- ❌ Слои Data и Domain не реализованы (папки пустые)
- ❌ Валидация форм
- ❌ Локальная база данных / кэш
- ❌ Сетевой слой (API)
- ❌ Авторизация
- ❌ Push-уведомления
- ❌ Тесты
- ❌ CI/CD

---

## ЭТАП 1 — Архитектурный фундамент
> Без этого всё остальное будет хаосом. Делается в первую очередь.

### 1.1 — Роутинг: `go_router`
- [ ] Добавить `go_router: ^14.x.x` в `pubspec.yaml`
- [ ] Создать `lib/core/router/app_router.dart` со всеми маршрутами
- [ ] Описать все текущие маршруты (greeting, onboarding, login, register, forgot_password, verify, reset_password)
- [ ] Заменить все `Navigator.push/pushReplacement(MaterialPageRoute(...))` на `context.go()` / `context.push()`
- [ ] Настроить `redirect` для авторизованных/неавторизованных зон
- [ ] В `main.dart` заменить `MaterialApp` на `MaterialApp.router`

**Пакет:** `go_router`
**Почему первым:** Все остальные экраны будут добавляться через роутер.

---

### 1.2 — State Management: `flutter_riverpod`
- [ ] Добавить `flutter_riverpod: ^2.x.x` и `riverpod_annotation` в `pubspec.yaml`
- [ ] Обернуть `runApp` в `ProviderScope`
- [ ] Создать `lib/core/providers/` для глобальных провайдеров
- [ ] Создать первый провайдер: `authStateProvider` (авторизован/нет)
- [ ] Подключить `authStateProvider` к `redirect` в `go_router`
- [ ] Перевести формы Login/Registration на `StateNotifier` или `AsyncNotifier`

**Пакет:** `flutter_riverpod`, `riverpod_annotation`, `build_runner`
**Почему Riverpod:** Отлично совместим с `go_router`, поддерживает `AsyncValue` для загрузки/ошибок, имеет кодогенерацию.

---

### 1.3 — Dependency Injection: `get_it` + `injectable`
- [ ] Добавить `get_it`, `injectable`, `injectable_generator` в `pubspec.yaml`
- [ ] Создать `lib/core/di/injection.dart`
- [ ] Зарегистрировать сервисы (AuthRepository, ApiClient и т.д.) через `@injectable`
- [ ] Настроить `configureDependencies()` в `main.dart`

**Пакет:** `get_it`, `injectable`
**Почему:** Позволяет легко подменять реализации для тестов (mock-объекты).

---

## ЭТАП 2 — Слои Domain и Data (Clean Architecture)
> Наполнение уже созданной структуры папок реальным кодом.

### 2.1 — Domain Layer (Бизнес-логика)
- [ ] Создать `lib/features/user_greeting/domain/entities/user_entity.dart`
- [ ] Создать `lib/features/user_greeting/domain/repositories/auth_repository.dart` (абстрактный класс)
- [ ] Создать Use Cases:
  - [ ] `login_usecase.dart`
  - [ ] `register_usecase.dart`
  - [ ] `logout_usecase.dart`
- [ ] Создать `lib/core/error/failure.dart` (классы ошибок: `ServerFailure`, `NetworkFailure`, `CacheFailure`)
- [ ] Добавить `dartz` для `Either<Failure, T>` или использовать `Result` паттерн

**Пакет:** `dartz` (опционально)

---

### 2.2 — Валидация форм
- [ ] Обернуть все `TextField` в `TextFormField` внутри `Form`
- [ ] Добавить `GlobalKey<FormState>` в экраны Login и Registration
- [ ] Реализовать валидаторы: пустое поле, формат email/логина, длина пароля, совпадение паролей
- [ ] Показывать ошибки под полями (через `errorText`)

**Пакет:** встроенный Flutter Form (без зависимостей), или `formz`

---

### 2.3 — Data Layer (Сетевой слой)
- [ ] Добавить `dio: ^5.x.x` в `pubspec.yaml`
- [ ] Создать `lib/core/network/dio_client.dart`
- [ ] Настроить BaseUrl, заголовки, interceptors (логирование, добавление токена)
- [ ] Создать `lib/features/user_greeting/data/datasources/auth_remote_datasource.dart`
- [ ] Создать `lib/features/user_greeting/data/models/user_model.dart` с `fromJson`/`toJson`
- [ ] Реализовать `AuthRepositoryImpl` (реализация абстрактного класса из Domain)
- [ ] Добавить обработку ошибок сети (timeout, 4xx, 5xx)

**Пакет:** `dio`, `json_annotation`, `json_serializable`, `build_runner`

---

## ЭТАП 3 — Авторизация и Локальное Хранилище
> Ключевой функционал любого медицинского приложения.

### 3.1 — Безопасное хранение токенов
- [ ] Добавить `flutter_secure_storage: ^9.x.x`
- [ ] Создать `lib/core/storage/secure_storage_service.dart`
- [ ] Методы: `saveToken()`, `getToken()`, `deleteToken()`
- [ ] Подключить к `AuthRepositoryImpl`

**Пакет:** `flutter_secure_storage`
**Почему:** Токены нельзя хранить в `SharedPreferences` — это небезопасно.

---

### 3.2 — Настройки и флаги: `shared_preferences`
- [ ] Добавить `shared_preferences`
- [ ] Хранить: `isFirstLaunch` (показывать онбординг или нет), `selectedTheme`, `language`
- [ ] Создать `lib/core/storage/preferences_service.dart`

**Пакет:** `shared_preferences`

---

### 3.3 — Локальная база данных: `drift` (SQLite)
- [ ] Добавить `drift`, `drift_dev`, `sqlite3_flutter_libs`
- [ ] Создать таблицы:
  - [ ] `medicines` (лекарства пользователя)
  - [ ] `schedules` (расписание приёма)
  - [ ] `intake_logs` (история приёмов)
- [ ] Создать DAO (Data Access Objects) для каждой таблицы
- [ ] Подключить к DI

**Пакет:** `drift` (бывший moor)
**Почему Drift:** Типобезопасные SQL-запросы, отличная поддержка Dart, реактивные стримы.

---

## ЭТАП 4 — Core-функционал приложения (Трекер)
> Основная ценность MediMo — это не авторизация, а трекер лекарств.

### 4.1 — Фича: Лекарства (`medicines`)
- [ ] Создать `lib/features/medicines/` со структурой data/domain/presentation
- [ ] Экран: список лекарств (HomeScreen)
- [ ] Экран: добавление лекарства (форма: название, дозировка, единица измерения)
- [ ] Экран: детали лекарства
- [ ] Экран: редактирование лекарства

---

### 4.2 — Фича: Расписание (`schedule`)
- [ ] Создать `lib/features/schedule/`
- [ ] Модель расписания (время, дни недели, частота)
- [ ] Экран выбора времени и дней приёма
- [ ] Виджет с отметкой "принял / пропустил"

---

### 4.3 — Фича: Статистика (`statistics`)
- [ ] Создать `lib/features/statistics/`
- [ ] Экран с графиком % соблюдения расписания
- [ ] Пакет для графиков: `fl_chart`

**Пакет:** `fl_chart`

---

### 4.4 — Нижнее меню навигации
- [ ] Реализовать `BottomNavigationBar` через `StatefulShellRoute` в `go_router`
- [ ] Вкладки: 🏠 Сегодня | 💊 Лекарства | 📊 Статистика | 👤 Профиль

---

## ЭТАП 5 — Push-уведомления
> Главная фича трекера — напоминания о приёме лекарств.

### 5.1 — Локальные уведомления: `flutter_local_notifications`
- [ ] Добавить `flutter_local_notifications`
- [ ] Создать `lib/core/notifications/notification_service.dart`
- [ ] Настроить каналы уведомлений (Android) и разрешения (iOS)
- [ ] Планировать уведомления по расписанию приёма
- [ ] Обрабатывать нажатие на уведомление → переход к конкретному лекарству (deep link)

**Пакет:** `flutter_local_notifications`, `timezone`

---

### 5.2 — Push-уведомления с сервера: `firebase_messaging`
- [ ] Подключить Firebase проект
- [ ] Добавить `firebase_core`, `firebase_messaging`
- [ ] Создать `lib/core/notifications/fcm_service.dart`
- [ ] Регистрировать FCM-токен при логине, отправлять на сервер
- [ ] Обрабатывать сообщения в foreground / background / terminated

**Пакет:** `firebase_core`, `firebase_messaging`

---

## ЭТАП 6 — Качество кода и UX

### 6.1 — Интернационализация (l10n)
- [ ] Добавить `flutter_localizations` (встроен во Flutter)
- [ ] Создать `lib/l10n/` с ARB-файлами (`app_ru.arb`, `app_en.arb`)
- [ ] Настроить `MaterialApp` с `localizationsDelegates` и `supportedLocales`
- [ ] Вынести все строки из виджетов в ARB-файлы

---

### 6.2 — Тёмная тема
- [ ] Добавить `AppTheme.darkTheme` в `core/theme/theme.dart`
- [ ] Передавать оба варианта темы в `MaterialApp`
- [ ] Читать предпочтение пользователя из `shared_preferences`
- [ ] Переключатель темы в настройках

---

### 6.3 — Обработка ошибок и состояний загрузки
- [ ] Создать `lib/core/widgets/error_widget.dart` (экран ошибки с кнопкой "Повторить")
- [ ] Создать `lib/core/widgets/loading_widget.dart` (shimmer-скелетон)
- [ ] Добавить `shimmer` пакет для скелетон-лоадеров
- [ ] Обрабатывать `AsyncValue.error` и `AsyncValue.loading` в каждом экране

**Пакет:** `shimmer`

---

### 6.4 — Доступность (Accessibility)
- [ ] Обернуть интерактивные элементы в `Semantics` или `Tooltip`
- [ ] Проверить контрастность цветов (WCAG AA)
- [ ] Поддержка динамического масштабирования шрифта (`textScaleFactor`)

---

## ЭТАП 7 — Аналитика, Мониторинг и Краши

### 7.1 — Firebase Crashlytics
- [ ] Добавить `firebase_crashlytics`
- [ ] Настроить `FlutterError.onError` и `PlatformDispatcher.onError`
- [ ] Добавить кастомные ключи/логи для критических операций

**Пакет:** `firebase_crashlytics`

---

### 7.2 — Firebase Analytics
- [ ] Добавить `firebase_analytics`
- [ ] Логировать ключевые события: `login`, `register`, `medicine_added`, `intake_marked`
- [ ] Настроить `GoRouterObserver` для автоматической трассировки экранов

**Пакет:** `firebase_analytics`

---

## ЭТАП 8 — Тестирование

### 8.1 — Unit-тесты
- [ ] Написать тесты для всех Use Cases (`test/`)
- [ ] Написать тесты для `StateNotifier`/`AsyncNotifier` провайдеров
- [ ] Мокировать зависимости через `mocktail`

**Пакет:** `mocktail`

---

### 8.2 — Widget-тесты
- [ ] Написать тесты для ключевых виджетов (LoginScreen, RegistrationScreen)
- [ ] Проверить валидацию форм
- [ ] Проверить навигацию

---

### 8.3 — Integration-тесты
- [ ] Написать E2E тест для сценария: Регистрация → Онбординг → Главный экран
- [ ] Настроить `patrol` для интеграционных тестов

**Пакет:** `patrol` (современная альтернатива `integration_test`)

---

## ЭТАП 9 — CI/CD и Релиз

### 9.1 — GitHub Actions / Fastlane
- [ ] Создать `.github/workflows/ci.yml`
- [ ] Шаги в CI: `flutter analyze`, `flutter test`, сборка APK/IPA
- [ ] Настроить автоматическую публикацию в Firebase App Distribution (для тестирования)
- [ ] Подготовить `Fastlane` для деплоя в Google Play / App Store

---

### 9.2 — Подготовка к релизу
- [ ] Настроить обфускацию кода (`--obfuscate --split-debug-info`)
- [ ] Настроить `ProGuard` правила для Android
- [ ] Заполнить метаданные приложения (иконка, сплэш, название)
- [ ] Пройти Google Play / App Store Review Guidelines для медицинских приложений
- [ ] Добавить Политику конфиденциальности (обязательно для медицинских приложений!)

---

## Сводная таблица пакетов

| Пакет | Категория | Этап |
|---|---|---|
| `go_router` | Роутинг | 1.1 |
| `flutter_riverpod` | State Management | 1.2 |
| `riverpod_annotation` + `build_runner` | Кодогенерация | 1.2 |
| `get_it` + `injectable` | DI | 1.3 |
| `dio` | HTTP-клиент | 2.3 |
| `json_serializable` | Сериализация JSON | 2.3 |
| `dartz` | Функциональные типы | 2.1 |
| `flutter_secure_storage` | Хранение токенов | 3.1 |
| `shared_preferences` | Настройки | 3.2 |
| `drift` | Локальная БД (SQLite) | 3.3 |
| `fl_chart` | Графики | 4.3 |
| `flutter_local_notifications` | Локальные уведомления | 5.1 |
| `firebase_core` + `firebase_messaging` | Push-уведомления | 5.2 |
| `shimmer` | Скелетон-лоадеры | 6.3 |
| `firebase_crashlytics` | Мониторинг крашей | 7.1 |
| `firebase_analytics` | Аналитика | 7.2 |
| `mocktail` | Моки для тестов | 8.1 |
| `patrol` | E2E тесты | 8.3 |

---

## Приоритет на ближайшие сессии

```
[Сейчас]    Этап 1.1 → go_router (роутинг)
[Сразу]     Этап 1.2 → flutter_riverpod (state management)  
[Потом]     Этап 2.2 → Валидация форм (без пакетов)
[Потом]     Этап 2.3 → Dio + API слой
[Потом]     Этап 3.1 → Хранение токенов
[Позже]     Этап 3.3 → Drift (локальная БД)
[Позже]     Этап 4.x → Core-функционал трекера
[Финал]     Этапы 5-9 → Уведомления, аналитика, тесты, CI/CD
```
