## 앱 화면 구성

<img width="6188" height="13235" alt="Group 2" src="https://github.com/user-attachments/assets/e3f5a5de-aabd-4a52-80af-5e4e9587a7e1" />

##  아키텍처 스타일

이 프로젝트는 **Flutter + Riverpod 기반 MVVM 변형 패턴**으로 설계되었습니다.  
각 계층은 역할별로 분리되어 유지보수와 확장성을 높였습니다.

### 계층별 구조

1. **Model (데이터 계층)**
   - `model/` 폴더에 위치
   - 데이터 구조 정의, JSON 직렬화/역직렬화 담당
   - 사용 예: `category_model.dart`, `product_model.dart`
   - 라이브러리: Freezed, JSON Serializable

2. **Repository (데이터 소스)**
   - `repository/` 폴더에 위치
   - API 호출(Dio) 및 로컬 데이터(Hive) 접근 담당
   - ViewModel에 데이터를 제공

3. **ViewModel / Provider (비즈니스 로직 / 상태 관리)**
   - `provider/` 폴더에 위치
   - 상태 관리, API 호출, 데이터 처리 담당
   - View와 Model을 연결하는 역할
   - 라이브러리: Riverpod, Riverpod Generator

4. **View (UI 계층)**
   - `view/` 폴더에 위치
   - 화면 구성과 사용자 인터페이스 담당
   - 예: `category_screen.dart`, `product_detail_screen.dart`

---

## 프로젝트 구조 
```
📦lib
 ┣ 📂category // 카테고리 관련 기능
 ┃ ┣ 📂model
 ┃ ┃ ┣ 📜category_model.dart
 ┃ ┃ ┣ 📜category_model.freezed.dart
 ┃ ┃ ┗ 📜category_model.g.dart
 ┃ ┣ 📂provider
 ┃ ┃ ┣ 📜category_provider.dart
 ┃ ┃ ┗ 📜category_provider.g.dart
 ┃ ┣ 📂repository
 ┃ ┃ ┣ 📜category_repository.dart
 ┃ ┃ ┗ 📜category_repository.g.dart
 ┃ ┗ 📂view
 ┃ ┃ ┗ 📜category_screen.dart 
 ┣ 📂common // 앱 전반에서 재사용되는 공통 기능
 ┃ ┣ 📂const
 ┃ ┃ ┗ 📜color.dart
 ┃ ┣ 📂layout
 ┃ ┃ ┗ 📜default_layout.dart
 ┃ ┣ 📂skeleton // 로딩 UI
 ┃ ┃ ┣ 📜product_detail_skeleton.dart
 ┃ ┃ ┗ 📜product_skeleton.dart
 ┃ ┣ 📂utils 
 ┃ ┃ ┣ 📜number_utils.dart
 ┃ ┃ ┗ 📜pagination_helper.dart
 ┃ ┗ 📂view
 ┃ ┃ ┣ 📜error_screen.dart
 ┃ ┃ ┣ 📜page_not_found.dart
 ┃ ┃ ┣ 📜scaffold_with_nav_bar.dart
 ┃ ┃ ┗ 📜splash_screen.dart
 ┣ 📂config
 ┃ ┣ 📂dio
 ┃ ┃ ┣ 📜dio_provider.dart
 ┃ ┃ ┗ 📜dio_provider.g.dart
 ┃ ┗ 📂router // 화면 라우팅 설정
 ┃ ┃ ┣ 📜route_names.dart
 ┃ ┃ ┣ 📜router_provider.dart
 ┃ ┃ ┗ 📜router_provider.g.dart
 ┣ 📂home
 ┃ ┣ 📂component
 ┃ ┃ ┗ 📜slide_image.dart
 ┃ ┗ 📂view
 ┃ ┃ ┣ 📜home_event_screen.dart
 ┃ ┃ ┣ 📜home_main_screen.dart
 ┃ ┃ ┗ 📜home_screen.dart
 ┣ 📂observer // riverpod 상태관리 로깅
 ┃ ┗ 📜logger.dart
 ┣ 📂product
 ┃ ┣ 📂component
 ┃ ┃ ┣ 📜product_list.dart
 ┃ ┃ ┣ 📜recent_search.dart
 ┃ ┃ ┗ 📜recent_viewd_product.dart
 ┃ ┣ 📂model
 ┃ ┃ ┣ 📜product_detail_model.dart
 ┃ ┃ ┣ 📜product_detail_model.freezed.dart
 ┃ ┃ ┣ 📜product_detail_model.g.dart
 ┃ ┃ ┣ 📜product_model.dart
 ┃ ┃ ┣ 📜product_model.freezed.dart
 ┃ ┃ ┣ 📜product_model.g.dart
 ┃ ┃ ┣ 📜recent_product_model.dart
 ┃ ┃ ┗ 📜recent_product_model.g.dart
 ┃ ┣ 📂provider
 ┃ ┃ ┣ 📜product_provider.dart
 ┃ ┃ ┣ 📜product_provider.g.dart
 ┃ ┃ ┣ 📜recent_product_provider.dart
 ┃ ┃ ┣ 📜recent_product_provider.g.dart
 ┃ ┃ ┣ 📜recent_search_provider.dart
 ┃ ┃ ┗ 📜recent_search_provider.g.dart
 ┃ ┣ 📂repository
 ┃ ┃ ┣ 📜product_repository.dart
 ┃ ┃ ┗ 📜product_repository.g.dart
 ┃ ┗ 📂view
 ┃ ┃ ┣ 📜category_product_screen.dart // 카테고리 선택 후 상품리스트 화면
 ┃ ┃ ┣ 📜keyword_product_screen.dart // 상품 검색 결과 상품리스트 화면
 ┃ ┃ ┣ 📜product_detail_screen.dart // 상품 상세 화면
 ┃ ┃ ┣ 📜product_search_screen.dart // 상품 검색 화면
 ┃ ┃ ┗ 📜recent_viewd_product_screen.dart // 최근 본 상품 화면
 ┣ 📂webview
 ┃ ┗ 📜product_1688_screen.dart
 ┗ 📜main.dart
 ```

## 사용 라이브러리

### 주요 Dependencies

| 패키지 | 버전 | 설명 |
|--------|------|------|
| `flutter_dotenv` | ^6.0.0 | 환경 변수(.env) 관리 |
| `dio` | ^5.9.0 | HTTP 클라이언트, API 통신 |
| `freezed_annotation` | ^2.4.4 | 불변 데이터 클래스 및 union 타입 생성 |
| `json_annotation` | ^4.9.0 | JSON 직렬화/역직렬화 어노테이션 |
| `intl` | ^0.20.2 | 날짜, 시간, 숫자 등의 국제화 지원 |
| `flutter_riverpod` | ^2.5.1 | 상태 관리 |
| `riverpod_annotation` | ^2.3.5 | Riverpod 코드 생성용 어노테이션 |
| `go_router` | ^16.2.0 | 라우팅 관리 |
| `infinite_scroll_pagination` | ^5.1.0 | 무한 스크롤 페이징 처리 |
| `skeletonizer` | ^2.1.0+1 | 로딩 상태 Skeleton UI |
| `webview_flutter` | ^4.13.0 | WebView 사용 |
| `hive` | ^2.2.3 | 로컬 NoSQL 데이터베이스 |
| `hive_flutter` | ^1.1.0 | Hive와 Flutter 연동 |
| `carousel_slider` | ^5.1.1 | 이미지/위젯 캐러셀 UI |

### Dev Dependencies

| 패키지 | 버전 | 설명 |
|--------|------|------|
| `build_runner` | ^2.4.12 | 코드 생성 도구 |
| `freezed` | ^2.5.7 | Freezed 코드 생성 |
| `json_serializable` | ^6.8.0 | JSON 직렬화 코드 생성 |
| `custom_lint` | ^0.6.5 | 커스텀 Lint 규칙 |
| `riverpod_generator` | ^2.4.3 | Riverpod 코드 생성 도구 |
| `riverpod_lint` | ^2.3.13 | Riverpod Lint 규칙 |
| `hive_generator` | ^2.0.1 | Hive 모델 코드 생성 |

## 개발 환경

- Flutter: 3.32.8 
- Dart: 3.8.1  


