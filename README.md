# TOGETHER — Android starter

**Different places. One experience.**

This is the first UI foundation for the TOGETHER Android watch-party app.

## Included
- Premium dark Material 3 interface with purple accents
- Home screen and bottom navigation
- Create-room flow and a local lobby preview
- Join-room code entry screen
- Placeholder Rooms, Messages and Profile screens
- GitHub Actions workflow to build a release APK in the cloud

## Important status
This is an early UI prototype, not a functioning multi-user streaming service. Room creation is currently local to the app. Video selection, network room codes, live chat, authentication, cloud storage and synchronized streaming are not implemented yet.

No software can honestly be guaranteed completely bug-proof or impossible to hack. The production app will be developed with security controls, code review, automated tests, dependency scanning, encrypted network traffic, secure authentication, server-side authorization, rate limiting, privacy protections and security testing. Those measures reduce risk but cannot promise zero vulnerabilities.

## Build the APK using GitHub Actions
The included workflow is `.github/workflows/android-apk.yml`.

To run it, the project must be uploaded to a GitHub repository:
1. Create a GitHub repository and upload the contents of this folder to its `main` branch.
2. Open the repository's **Actions** tab.
3. Select **Build TOGETHER Android APK** and choose **Run workflow** (or let it run after a push).
4. When the workflow completes, open its run and download the `together-android-apk` artifact.
5. Extract the downloaded artifact to get `app-release.apk`, then install it on your Android phone. Android may ask you to allow installs from the browser or file manager you used.

GitHub account access and the upload/run action must be performed by the account owner; I cannot sign in to third-party services or publish the repository on your behalf.

## Local build (computer with Flutter + Android tooling)
1. Run `flutter pub get`
2. Run `flutter analyze`
3. Run `flutter build apk --release`

## Next engineering milestone
Add Android local-video selection and playback, then implement server-authoritative room state and synchronization. For remote viewers, the host's video must be transmitted through an authorized peer-to-peer or server/CDN delivery path; playback commands alone do not share the video file.
