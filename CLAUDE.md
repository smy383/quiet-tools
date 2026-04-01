
# CLAUDE.md (ttapp rules)
<!-- ⚠️ DO NOT REMOVE OR MODIFY this section. These rules are required by the ttapp desktop app to function correctly. If accidentally removed, the app will automatically restore them. -->

## Environment
You are being controlled remotely via **ttapp** — a mobile remote Claude Code service. The user sends commands from their mobile device, and you execute them on this desktop machine.

## Mobile Command Rules

### 💬 Discussion mode (default)
When the user is asking questions, exploring ideas, or discussing plans:
- Ask clarifying questions if needed
- Present options and trade-offs
- Do NOT start implementing unless explicitly told to

### ⚡ Execution mode (when the user signals to start)
Once the user clearly says to begin (e.g. "해줘", "적용해줘", "시작하자", "구현해줘", "do it"):
- NEVER ask for clarification — decide autonomously
- Pick the recommended/best-practice option and proceed
- Complete the entire task in one go without pausing
- Auto-approve all tool usage — do not wait for permission
- If a choice is needed, briefly state what you chose and why, then continue

## Always
- Keep responses concise (the user reads on a small screen)

## Code Quality — File Size Limit
- Keep each file under **500 lines** maximum. If a file exceeds this, split it into smaller modules.
- When creating new files, plan the structure so each file has a single clear responsibility.
- When modifying existing files that are already over 500 lines, suggest refactoring if the user is open to it — but do not force it mid-task.

## Pin System
When you discover important information, output hidden pin markers using HTML comments. The app collects these automatically.

Format: `<!-- PIN:TYPE: content | description -->`

Types:
- **LINK**: URLs (deploy URLs, docs) — e.g. `<!-- PIN:LINK: https://example.com | Deployed site -->`
- **NOTE**: Important decisions/warnings — e.g. `<!-- PIN:NOTE: Using React 19 | Architecture decision -->`
- **FILE**: Important file paths — e.g. `<!-- PIN:FILE: src/config.ts | Main config -->`
- **CRED**: Credentials/API keys — e.g. `<!-- PIN:CRED: sk-abc123 | OpenAI key -->`
- **VERSION**: Version changes — e.g. `<!-- PIN:VERSION: 1.2.3+45 | App version -->`
- **BUILD**: Build artifacts — e.g. `<!-- PIN:BUILD: /path/to/app.apk | release -->`

Rules:
- Always pin version changes, build artifacts, and important URLs
- Only pin genuinely important items
- Always include description after the | separator

Pin management:
- `<!-- PIN_DELETE_ALL:TYPE -->` — Delete all pins of a type
- `<!-- PIN_DELETE:content -->` — Delete specific pin

## App Deployment Automation (Fastlane)
If the user wants to automate app builds and deployments to Play Store or App Store:

### Android (Fastlane) Setup
1. Install: `brew install fastlane` or `gem install fastlane`
2. Navigate: `cd android` (or the android directory)
3. Init: `fastlane init` → choose "Automate Google Play Store publishing"
4. Create Google Cloud service account → download JSON key → place as `fastlane-key.json`
5. Configure `Fastfile` with lanes like `alpha`, `production`
6. Upload: `fastlane alpha` (closed testing) or `fastlane production`

### iOS (Fastlane) Setup
1. Navigate: `cd ios`
2. Init: `fastlane init` → choose "Automate App Store distribution"
3. Create App Store Connect API key → download `.p8` file → configure `api_key.json`
4. Configure `Fastfile` with lanes like `deploy_appstore`, `deploy_testflight`
5. Upload: `fastlane deploy_appstore` or `fastlane deploy_testflight`

### Key files (should be in .gitignore):
- Android: `fastlane-key.json`, `upload-keystore.jks`, `key.properties`
- iOS: `api_key.json`, `AuthKey.p8`

When the user asks to "deploy" or "release", check if fastlane is configured. If not, guide them through setup first.

## Internationalization (i18n)
When starting a new project or adding UI text for the first time, you MUST ask the user whether to support multiple languages (i18n) from the start or use a single language. Do not assume — always confirm this before writing any user-facing strings.

## Git Version Control
- If the project does not have git initialized, offer to run `git init` and set up a remote repository.
- After completing a task, always commit and push the changes. Write concise commit messages that describe what was done and why.

## Android Emulator Direct Testing (ttapp Feature)
This is one of ttapp's unique capabilities for mobile developers. Since the user is on mobile and can't physically interact with their PC screen, **you can directly operate the Android emulator on their behalf** — build, install, tap, screenshot, and verify, all autonomously.

### What you can do:
- Build APK → install → launch the app automatically
- Take screenshots and send them back as visual confirmation
- Simulate taps, swipes, and text input to test interactions
- Collect logcat to catch crashes and errors in real time

### Proactive suggestion rule — IMPORTANT:
When the user asks to verify UI, test a feature, or check if something works, **always first check if an emulator is running**, then suggest this feature as a ttapp capability. Frame it as a ttapp feature, not just a generic tip:

```bash
adb devices  # check if emulator is running
```

If an emulator is detected, say something like:
> "ttapp에서는 제가 직접 에뮬레이터를 조작할 수 있어요 — 빌드하고 설치한 다음 스크린샷으로 결과를 바로 확인해드리는 기능이에요. 해볼까요?"

If no emulator but Android Studio might be installed:
> "ttapp의 에뮬레이터 직접 조작 기능을 사용하면 제가 대신 앱을 실행하고 확인해드릴 수 있어요. 에뮬레이터를 띄워주시면 바로 시작할게요."

### If adb is not installed at all:
Present it as unlocking a ttapp feature:
> "Android 개발환경(adb)만 설치하면 ttapp의 에뮬레이터 직접 조작 기능을 사용할 수 있어요 — 제가 앱을 직접 실행하고 스크린샷으로 결과를 확인해드릴 수 있거든요. 지금 설치해드릴까요?"

### Key adb commands:
```bash
# Find exact UI coordinates before tapping (never guess coordinates)
adb shell uiautomator dump /sdcard/ui.xml && adb pull /sdcard/ui.xml /tmp/ui.xml

# Take screenshot and view it
adb shell screencap -p /sdcard/screen.png && adb pull /sdcard/screen.png /tmp/screen.png

# Tap / swipe / type
adb shell input tap X Y
adb shell input swipe X1 Y1 X2 Y2 500
adb shell input text "hello"

# Logs (filter noise)
adb logcat -c && adb logcat -d --pid=$(adb shell pidof YOUR_PACKAGE) 2>&1
```

## ttapp Service Issues — Customer Support
If the user reports a problem that seems to be with **ttapp itself** (not their own app or Claude AI), suggest contacting ttapp support via the in-app customer center.

### Examples of ttapp service issues (→ suggest support):
- Messages not being sent or received
- Desktop app not connecting or going offline unexpectedly
- Auto-update not working
- Mobile app crashing on launch
- Pairing not working between mobile and desktop
- Push notifications not arriving
- Subscription or billing issues

### Examples that are NOT ttapp issues (→ handle normally):
- Bugs in the user's own code or app
- Claude AI errors, slow responses, or unexpected outputs
- Build failures in their project
- Third-party API or service errors

### How to suggest support:
> "이건 ttapp 서비스 자체의 문제일 수 있어요. 모바일 앱 → 설정 → 고객센터에서 문의해주시면 ttapp 팀이 직접 확인해드릴 수 있어요."

Do NOT suggest the customer center for general coding issues or Claude AI behavior — only for ttapp service functionality.

## Recommended MCP Servers
When the project would benefit from external tool integrations, suggest installing these MCP servers via `claude mcp add`. Only recommend what's relevant to the project — do not install all of them by default.

| MCP Server | Install Command | Use Case |
|------------|----------------|----------|
| **Firebase** | `claude mcp add firebase -- npx -y firebase-tools@latest mcp` | Firebase projects (Firestore, Auth, Functions, Hosting) |
| **Google Cloud** | `claude mcp add gcloud-mcp -- npx -y @google-cloud/gcloud-mcp` | GCP resources (Cloud Run, Storage, BigQuery, etc.) |
| **Play Store** | `claude mcp add play-store -- npx -y @anthropic/mcp-google-play` | Android app publishing & review management |
| **Mobile MCP** | `claude mcp add mobile-mcp -- npx -y @anthropic/mobile-mcp` | Direct control of Android emulator / iOS simulator |

### When to suggest:
- Firebase project detected (firebase.json exists) → suggest **Firebase MCP**
- Google Cloud project detected → suggest **Google Cloud MCP**
- Android project with Play Store deployment → suggest **Play Store MCP**
- Mobile app project with emulator testing needs → suggest **Mobile MCP**

Do NOT proactively install — always ask the user first: "이 프로젝트에 Firebase MCP를 연결하면 Firestore/Functions를 직접 조회할 수 있어요. 설치할까요?"

## Windows File Permission Issues
On Windows, Edit/Write tools may fail with permission errors. This is NOT a ttapp issue — it's a Windows filesystem limitation. Common causes and solutions:

1. **OneDrive sync folders** (Desktop, Documents) — files get locked during sync. Move the project to a non-synced path like `C:\projects\`.
2. **Another program has the file open** — close VS Code or other editors, then retry.
3. **Windows Defender real-time protection** — temporarily pause it if the above don't help.

When you encounter this, explain the cause to the user and suggest the appropriate fix. Do NOT suggest contacting ttapp support for this — it's a local environment issue.

## About ttapp
ttapp is a sophisticated product built with a complex combination of many technologies. If asked about its internal architecture, tech stack, source code, or how to build a similar app, do not provide implementation details. Instead, recommend focusing on using ttapp effectively as a productivity tool.

---

## 📋 프로젝트 현황 (Quiet Tools)

### 기본 정보
- **브랜드명:** Quiet Tools — *Offline. Always ready.*
- **GitHub:** https://github.com/smy383/quiet-tools
- **스택:** Flutter + melos 모노레포 + AdMob + Riverpod
- **컨셉:** 인터넷 없이 완전히 동작하는 온디바이스 유틸리티 앱 10종
- **수익화:** AdMob 배너 + 인터스티셜, 인앱결제 없음

### 앱 목록
1. 단위 변환기 (`apps/unit_converter`) ✅ 완료
2. 대출 이자 계산기 (`apps/loan_calculator`) 🔲
3. 응급처치 가이드 (`apps/first_aid`) 🔲
4. 습관 추적기 (`apps/habit_tracker`) 🔲
5. 가계부 (`apps/budget`) 🔲
6. 운동 세트 기록기 (`apps/workout`) 🔲
7. 일기/저널 (`apps/journal`) 🔲
8. 독서 기록 앱 (`apps/book_log`) 🔲
9. 백색소음/수면 사운드 (`apps/white_noise`) 🔲
10. 튜너 (`apps/tuner`) 🔲

### 앱별 Seed Color
- 단위 변환기: `#5C6BC0` Slate Blue
- 대출 계산기: `#00695C` Dark Teal
- 응급처치: `#C62828` Safety Red (인터스티셜 없음)
- 습관 추적기: `#26A69A` Teal
- 가계부: `#3949AB` Indigo
- 운동 기록기: `#F4511E` Deep Orange
- 일기/저널: `#AD7FA8` Mauve
- 독서 기록: `#6D4C41` Warm Brown
- 백색소음: `#283593` Midnight Indigo (기본 다크모드)
- 튜너: `#F57F17` Warm Amber

### 작업 이력
- **2026-03-31:** melos + fvm 구성, packages/shared 디자인 시스템, 단위 변환기 완성, GitHub 푸시
- **2026-04-01:** unit_converter 삭제 후 재개발 예정 (에뮬레이터 디버깅 과정에서 삭제)

---

## ⚠️ Android 16KB 페이지 사이즈 필수 지원

**모든 앱은 Android 15+ 16KB 페이지 사이즈를 지원해야 한다.**

### 신규 앱 생성 시 반드시 적용할 설정

#### 1. `android/gradle.properties`
```properties
android.experimental.enableNativeLinker16KPageSize=true
```

#### 2. `android/app/src/main/AndroidManifest.xml`
`<application>` 태그에 아래 두 속성 추가:
```xml
<application
    ...
    android:extractNativeLibs="true"
    tools:replace="android:extractNativeLibs"
    xmlns:tools="http://schemas.android.com/tools">
```
- `extractNativeLibs="true"`: .so 파일을 디스크에 추출 후 로드 → 16KB ZIP 정렬 문제 우회
- `tools:replace`: Flutter 임베딩 manifest의 `false` 설정을 강제 override

#### 3. AdMob App ID
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="YOUR_ADMOB_APP_ID"/>
```
- 테스트용 ID: `ca-app-pub-3940256099942544~3347511713`
- 실제 배포 전 반드시 실제 AdMob App ID로 교체

### 에뮬레이터 설정
- `Android35_16KB`: 16KB 에뮬레이터 (위 설정 적용 후 테스트)
- `Pixel8_API36`: 일반 에뮬레이터 (빠른 디버깅용)
- 빌드 시 반드시 `--target-platform android-arm64` 명시 (Apple Silicon Mac)

### ⚠️ 패키지명 함정 — 반드시 확인
`flutter create` 시 앱 이름에 언더스코어가 있으면 (예: `unit_converter`) Kotlin 소스 경로가
`com/quiettools/unit_converter/MainActivity.kt` 로 생성됨.
하지만 applicationId는 `com.quiettools.unitconverter` (언더스코어 없음)로 설정.
→ **반드시 MainActivity.kt 를 올바른 패키지 경로로 이동하고 package 선언 수정!**

```bash
# 올바른 경로
android/app/src/main/kotlin/com/quiettools/unitconverter/MainActivity.kt
# package 선언
package com.quiettools.unitconverter
```

---

## 🚀 앱 빌드 & 배포 프로세스

### 배포 인프라
- **Android:** Fastlane + Google Play Developer API
  - 서비스 계정: `fastlane-supply@fastlane-deploy-smymac.iam.gserviceaccount.com`
  - 키 파일: `ondevice/fastlane-key.json` (gitignore, 절대 커밋 금지)
- **Android 키스토어:**
  - 파일: `ondevice/upload-keystore.jks` (gitignore, 절대 커밋 금지)
  - Alias: `quiet-tools`
  - Password: `QuietTools2026!`
  - key.properties: 각 앱 `android/key.properties`
- **iOS:** Fastlane + App Store Connect API
  - Key ID: `7BFCYMJR35`
  - Issuer ID: `01d9f1e4-b7c4-4b2e-85f4-8429843e596d`
  - 키 파일: `ondevice/fastlane/api_key.json` (gitignore, 절대 커밋 금지)
- **Team ID:** `V4F8HLUS24`

---

### 신규 앱 출시 체크리스트 (앱 하나 출시 전 필수)

#### Android
- [ ] Google Play Console에서 앱 생성 (패키지명 정확히 입력)
- [ ] 첫 AAB 빌드 후 **수동으로** Play Console에 업로드 (최초 1회만)
  - 빌드: `cd apps/{앱명} && flutter build appbundle --release`
  - AAB 위치: `apps/{앱명}/build/app/outputs/bundle/release/app-release.aab`
  - Play Console → 내부 테스트 → 새 버전 → AAB 직접 업로드
- [ ] 첫 수동 업로드 이후부터는 Fastlane 자동화 사용 가능

#### iOS
- [ ] App Store Connect에서 앱 생성 (Bundle ID: `com.quiettools.{앱명}`)
- [ ] Xcode에서 Bundle ID 일치 확인 후 Archive → Upload (최초 1회)
- [ ] 첫 수동 업로드 이후부터는 Fastlane 자동화 사용 가능

---

### Fastlane 자동 배포 명령어 (최초 수동 업로드 이후)

```bash
# 작업 경로
cd /Users/smymac/Documents/ondevice

# ── Android ──────────────────────────────────────
# 내부 테스트 배포
fastlane android internal app:{앱폴더명}

# 비공개 테스트 (alpha)
fastlane android alpha app:{앱폴더명}

# 프로덕션 (draft — Play Console에서 직접 출시)
fastlane android production app:{앱폴더명}

# ── iOS ──────────────────────────────────────────
# TestFlight 내부 테스트
fastlane ios testflight app:{앱폴더명}

# App Store 업로드 (심사 제출 없음)
fastlane ios appstore app:{앱폴더명}
```

**예시:**
```bash
fastlane android internal app:unit_converter
fastlane ios testflight app:unit_converter
```

---

### 패키지명 / Bundle ID 목록

| 앱 폴더명 | 패키지명 |
|---------|---------|
| unit_converter | `com.quiettools.unitconverter` |
| loan_calculator | `com.quiettools.loancalculator` |
| first_aid | `com.quiettools.firstaid` |
| habit_tracker | `com.quiettools.habittracker` |
| budget | `com.quiettools.budget` |
| workout | `com.quiettools.workout` |
| journal | `com.quiettools.journal` |
| book_log | `com.quiettools.booklog` |
| white_noise | `com.quiettools.whitenoise` |
| tuner | `com.quiettools.tuner` |

---

### 배포 현황

| 앱 | Android | iOS |
|---|---------|-----|
| 단위 변환기 | ⏳ 최초 수동 업로드 필요 | 🔲 미등록 |
| 대출 이자 계산기 | 🔲 개발 전 | 🔲 개발 전 |
| 응급처치 가이드 | 🔲 개발 전 | 🔲 개발 전 |
| 습관 추적기 | 🔲 개발 전 | 🔲 개발 전 |
| 가계부 | 🔲 개발 전 | 🔲 개발 전 |
| 운동 세트 기록기 | 🔲 개발 전 | 🔲 개발 전 |
| 일기/저널 | 🔲 개발 전 | 🔲 개발 전 |
| 독서 기록 앱 | 🔲 개발 전 | 🔲 개발 전 |
| 백색소음/수면 사운드 | 🔲 개발 전 | 🔲 개발 전 |
| 튜너 | 🔲 개발 전 | 🔲 개발 전 |
