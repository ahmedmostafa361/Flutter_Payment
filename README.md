# Flutter Payment — Stripe Payment Sheet Demo

A minimal Flutter app demonstrating a complete Stripe payment flow using the
native payment sheet, backed by a self-built Node.js/Express service.

Card details never touch the app or the backend — they go directly from the
Stripe SDK to Stripe, which is what keeps the integration PCI compliant. The
secret key stays server-side; the app only ever holds the publishable key.

Built with Stripe **test mode**. No real money moves.

## Backend

This app requires the companion service, which creates the payment intents:

**[ahmedmostafa361/stripe-payment-service](https://github.com/ahmedmostafa361/stripe-payment-service)**

Start it first — the app cannot work on its own.

## How it works

1. The app sends the order amount to `POST /api/payments/create-payment-intent`
2. The Node service asks Stripe to create a payment intent and returns a `clientSecret`
3. The app passes that secret to `Stripe.instance.initPaymentSheet(...)`
4. `presentPaymentSheet()` opens the native sheet and collects the card
5. Stripe confirms the payment

The amount is sent as an integer in the smallest currency unit — `25000` is
250.00 EGP. Floats are rejected by the backend on purpose.

## Running it

Start the backend, then:

```bash
flutter pub get
flutter run
```

Set your own publishable key in `lib/main.dart`:

```dart
Stripe.publishableKey = 'pk_test_your_key_here';
```

### Connecting to the backend

The backend runs on your machine, so the device needs a route to it:

| Device            | URL in `main.dart`      |
|-------------------|-------------------------|
| Physical phone    | `http://localhost:3000` + `adb reverse` (below) |
| Android emulator  | `http://10.0.2.2:3000`  |
| iOS simulator     | `http://localhost:3000` |

For a physical device over USB:

```bash
adb reverse tcp:3000 tcp:3000
```

This forwards port 3000 on the phone to port 3000 on the computer, which avoids
Wi-Fi, firewall and router client-isolation problems entirely. It has to be
re-run after unplugging the cable.

## Test cards

| Card                  | Result              |
|-----------------------|---------------------|
| 4242 4242 4242 4242   | Succeeds            |
| 4000 0000 0000 0002   | Declined            |
| 4000 0025 0000 3155   | Requires 3D Secure  |

Any future expiry date, any CVC.

## Android configuration

`flutter_stripe` needs four changes beyond a default Flutter project. Missing any
of them causes a crash rather than a clear error, so they are worth noting:

- `MainActivity` extends `FlutterFragmentActivity`, not `FlutterActivity` — the
  payment sheet is a fragment and needs a fragment host
- `NormalTheme` descends from `Theme.AppCompat` in both `values/styles.xml` and
  `values-night/styles.xml` — a non-AppCompat theme throws at runtime, and
  missing the night variant produces a crash only in dark mode
- `android:usesCleartextTraffic="true"` — required for plain HTTP to the local
  backend during development only, not something to ship
- `INTERNET` permission declared explicitly, since Flutter only injects it into
  debug builds

## Built with

- `flutter_stripe` ^13.0.0
- `dio` ^5.11.0
- Node.js / Express backend ([separate repo](https://github.com/ahmedmostafa361/stripe-payment-service))

## Scope

This is a deliberately minimal demo — a single screen with a hardcoded amount,
so the payment flow is readable without any surrounding architecture. Errors are
separated into three cases: Stripe failures, network failures, and user
cancellation, which is not treated as an error.

The backend implements a signature-verified webhook for
`payment_intent.succeeded`, which is the only trustworthy confirmation that an
order was paid — the payment sheet closing successfully does not prove the
payment completed, since the user can quit the app first.
