# Gas Station Terminal Redesign - TODO

## 🎯 Goal
Transform the current modern/sleek terminal design into a realistic gas station payment terminal with German language support and professional Lucide icons.

---

## 🎨 Visual Design Changes

### Terminal Hardware (POSTerminal.vue)
- [ ] Change background from sleek gradient to industrial gray/beige
- [ ] Make terminal frame more boxy and chunky (less rounded corners)
- [ ] Add visible screws/mounting hardware details
- [ ] Make card reader slot more prominent and realistic
- [ ] Make receipt printer slot wider and more obvious
- [ ] Change status lights to larger, more prominent LEDs
- [ ] Add weathered/used texture to casing

### Screen Design (All Screens)
- [ ] Change background to LCD green/yellow monochrome aesthetic (option)
- [ ] Use higher contrast colors (black text on bright green/yellow)
- [ ] Simplify fonts to monospace/LCD style
- [ ] Remove gradients and fancy effects
- [ ] Use solid colors for buttons
- [ ] Make touch targets larger (gas station glove-friendly)
- [ ] Reduce animation complexity (simpler, more direct)

### Button Design
- [ ] Change to large, chunky rectangular buttons
- [ ] Use bright colors: GREEN (OK/Confirm), RED (Cancel), YELLOW (Back)
- [ ] Add visible borders and depth (3D button effect)
- [ ] Increase button size significantly (80px+ height)
- [ ] Add tactile feedback animations (deeper press effect)
- [ ] Use all-caps text on buttons
- [ ] Add icon + text labels on buttons

### Color Scheme
- [ ] Primary action: Bright green (#22c55e) with dark green border
- [ ] Cancel/Error: Bright red (#ef4444) with dark red border
- [ ] Back/Secondary: Bright yellow (#fbbf24) with dark yellow border
- [ ] Screen background: Dark gray (#1f2937) or LCD green (#7ed321)
- [ ] Text: High contrast white or black
- [ ] Remove blue accent colors (too modern)

---

## 🔄 Icon Migration (Emoji → Lucide)

### TerminalWelcome.vue
- [ ] Replace 💳 with `<CreditCard />` (size 80)
- [ ] Replace ⚡ with `<Zap />` (size 24)
- [ ] Replace 💰 with `<DollarSign />` (size 24)
- [ ] Replace 📱 with `<Smartphone />` (size 24)
- [ ] Replace 👆 with `<Hand />` or `<TouchpadOff />` (size 48)

### TerminalPaymentMethod.vue
- [ ] Replace 💳 with `<CreditCard />` (size 64)
- [ ] Replace 💵 with `<Banknote />` (size 64)
- [ ] Replace 📱 with `<Smartphone />` (size 64)
- [ ] Replace 🔒 with `<Lock />` (size 20)

### TerminalProductSelect.vue
- [ ] Replace 🖥️ with `<Monitor />` (size 40)
- [ ] Replace 💡 with `<Lightbulb />` (size 40)
- [ ] Replace 🔧 with `<Wrench />` (size 40)
- [ ] Replace ⚙️ with `<Settings />` (size 40)
- [ ] Replace ✓ with `<Check />` (size 20)
- [ ] Replace 🎉 with `<Sparkles />` (size 20)

### TerminalReview.vue
- [ ] Replace 💳 with `<CreditCard />` (size 24)
- [ ] Replace 📦 with `<Package />` (size 24)
- [ ] Replace 💰 with `<DollarSign />` (size 24)
- [ ] Replace ℹ️ with `<Info />` (size 20)

### TerminalProcessing.vue
- [ ] Replace 💳 with `<CreditCard />` (size 80)
- [ ] Replace spinner with `<Loader2 />` with spin animation (size 60)
- [ ] Replace ⏳ with `<Clock />` (size 20)
- [ ] Replace ✓ with `<Check />` (size 20)
- [ ] Replace 🔒 with `<Lock />` (size 20)

### TerminalSuccess.vue
- [ ] Replace ✓ with `<CheckCircle />` (size 80)
- [ ] Replace 🏪 with `<Store />` or `<Building />` (size 32)
- [ ] Replace 📧 with `<Mail />` (size 20)
- [ ] Replace 🎉 with `<PartyPopper />` or `<Sparkles />` (size 20)

### TerminalError.vue
- [ ] Replace ❌ with `<XCircle />` (size 80)
- [ ] Replace 🔄 with `<RotateCw />` (size 20)
- [ ] Replace ✕ with `<X />` (size 20)
- [ ] Replace 📞 with `<Phone />` (size 20)
- [ ] Replace ℹ️ with `<AlertTriangle />` (size 20)

---

## 🌍 German Translation Implementation

### Setup
- [ ] Check existing i18n configuration in main app
- [ ] Create `frontend/src/locales/terminal-de.json`
- [ ] Create `frontend/src/locales/terminal-en.json`
- [ ] Configure terminal-specific translation loading

### TerminalWelcome.vue Translations
```json
{
  "terminal": {
    "welcome": {
      "title": "Welcome to",
      "brand": "POS Terminal",
      "subtitle": "Interactive Product Demo",
      "touch": "Touch anywhere to start",
      "features": {
        "fast": "Fast & Secure",
        "payment": "Multiple Payment Options",
        "easy": "Easy to Use"
      },
      "footer": "Powered by Prem-Lichtwerbung"
    }
  }
}
```

### TerminalPaymentMethod.vue Translations
- [ ] "Select Payment Method" → "Zahlungsmethode wählen"
- [ ] "Choose how you would like to pay" → "Wie möchten Sie bezahlen?"
- [ ] "Card Payment" → "Kartenzahlung"
- [ ] "Cash Payment" → "Barzahlung"
- [ ] "Mobile Payment" → "Mobile Zahlung"
- [ ] "Credit / Debit" → "Kredit- / Debitkarte"
- [ ] "Bills & Coins" → "Scheine & Münzen"
- [ ] "Apple Pay / Google Pay" → "Apple Pay / Google Pay"
- [ ] "Most Popular" → "Beliebteste"
- [ ] "New" → "Neu"
- [ ] "Continue" → "Weiter"
- [ ] "Please select a payment method" → "Bitte Zahlungsmethode wählen"
- [ ] "Your payment is secure and encrypted" → "Ihre Zahlung ist sicher und verschlüsselt"

### TerminalProductSelect.vue Translations
- [ ] "Bundle Products" → "Bundle-Produkte"
- [ ] "Your complete POS terminal package" → "Ihr komplettes POS-Terminal-Paket"
- [ ] "POS Terminal" → "POS-Terminal"
- [ ] "LED Menu Board" → "LED-Menütafel"
- [ ] "Professional Installation" → "Professionelle Installation"
- [ ] "Software Setup & Training" → "Software-Einrichtung & Schulung"
- [ ] "FREE" → "KOSTENLOS"
- [ ] "Subtotal" → "Zwischensumme"
- [ ] "Bundle Discount" → "Bundle-Rabatt"
- [ ] "Total" → "Gesamt"
- [ ] "Continue to Review" → "Weiter zur Überprüfung"
- [ ] "You save €600 with this bundle!" → "Sie sparen 600 € mit diesem Bundle!"

### TerminalReview.vue Translations
- [ ] "Review Your Order" → "Bestellung überprüfen"
- [ ] "Please confirm the details below" → "Bitte Details unten bestätigen"
- [ ] "Payment Method" → "Zahlungsmethode"
- [ ] "Bundle Items" → "Bundle-Artikel"
- [ ] "Price Breakdown" → "Preisaufschlüsselung"
- [ ] "Tax" → "MwSt."
- [ ] "Confirm & Pay" → "Bestätigen & Bezahlen"
- [ ] "Edit Order" → "Bestellung bearbeiten"
- [ ] "By confirming, you agree to our terms and conditions" → "Mit der Bestätigung akzeptieren Sie unsere AGB"

### TerminalProcessing.vue Translations
- [ ] "Processing Payment..." → "Zahlung wird verarbeitet..."
- [ ] "Please wait, do not refresh the page" → "Bitte warten, Seite nicht aktualisieren"
- [ ] "Verifying payment method" → "Zahlungsmethode wird überprüft"
- [ ] "Contacting payment gateway" → "Verbindung zum Zahlungsanbieter"
- [ ] "Authorizing transaction" → "Transaktion wird autorisiert"
- [ ] "Confirming order" → "Bestellung wird bestätigt"
- [ ] "Authorizing Payment..." → "Zahlung wird autorisiert..."
- [ ] "Finalizing Order..." → "Bestellung wird abgeschlossen..."
- [ ] "Payment Successful!" → "Zahlung erfolgreich!"
- [ ] "Redirecting to confirmation..." → "Weiterleitung zur Bestätigung..."
- [ ] "Secure encrypted transaction" → "Sichere verschlüsselte Transaktion"

### TerminalSuccess.vue Translations
- [ ] "Order Confirmed!" → "Bestellung bestätigt!"
- [ ] "Thank you for your purchase" → "Vielen Dank für Ihren Einkauf"
- [ ] "Order Number" → "Bestellnummer"
- [ ] "TOTAL" → "GESAMT"
- [ ] "Payment Method:" → "Zahlungsmethode:"
- [ ] "Add to Cart" → "In den Warenkorb"
- [ ] "New Transaction" → "Neue Transaktion"
- [ ] "A confirmation email has been sent" → "Eine Bestätigungs-E-Mail wurde gesendet"
- [ ] "You saved €600 with this bundle!" → "Sie haben 600 € mit diesem Bundle gespart!"

### TerminalError.vue Translations
- [ ] "Transaction Failed" → "Transaktion fehlgeschlagen"
- [ ] "Your payment could not be processed" → "Ihre Zahlung konnte nicht verarbeitet werden"
- [ ] "Unable to connect to payment gateway" → "Keine Verbindung zum Zahlungsanbieter"
- [ ] "The transaction timed out" → "Zeitüberschreitung der Transaktion"
- [ ] "Your payment method was declined" → "Ihre Zahlungsmethode wurde abgelehnt"
- [ ] "An unexpected error occurred" → "Ein unerwarteter Fehler ist aufgetreten"
- [ ] "Error Code:" → "Fehlercode:"
- [ ] "Try Again" → "Erneut versuchen"
- [ ] "Cancel Transaction" → "Transaktion abbrechen"
- [ ] "Contact Support" → "Support kontaktieren"
- [ ] "Need help? Call us at" → "Benötigen Sie Hilfe? Rufen Sie uns an unter"

### Component Implementation
- [ ] Import `useI18n` from vue-i18n in each screen component
- [ ] Replace hardcoded strings with `t('terminal.key.path')`
- [ ] Test language switching in all screens

---

## 🔘 Language Switcher Component

### Create TerminalLanguageSwitcher.vue
- [ ] Create component file
- [ ] Add DE/EN toggle button
- [ ] Use flag emojis or icons (🇩🇪 🇬🇧)
- [ ] Position in top-right corner of terminal screen
- [ ] Style to match gas station terminal aesthetic
- [ ] Implement language switching logic
- [ ] Persist language choice in localStorage

### Integration
- [ ] Add LanguageSwitcher to POSTerminal.vue
- [ ] Position above or within screen bezel
- [ ] Ensure visibility on all screens
- [ ] Test switching between German and English

---

## 🧪 Testing Checklist

### Visual Testing
- [ ] Terminal looks like gas station terminal (chunky, industrial)
- [ ] Buttons are large and clearly labeled
- [ ] Colors are high contrast and easy to read
- [ ] Icons are clear and appropriate
- [ ] Hardware details look realistic

### Functional Testing
- [ ] All Lucide icons render correctly
- [ ] Language switcher works on all screens
- [ ] German translations are accurate and complete
- [ ] English translations remain correct
- [ ] Navigation works with new design
- [ ] All interactions feel responsive

### Flow Testing
- [ ] Welcome → Payment Method (DE & EN)
- [ ] Payment Method → Product Select (DE & EN)
- [ ] Product Select → Review (DE & EN)
- [ ] Review → Processing → Success (DE & EN)
- [ ] Error screen displays correctly (DE & EN)
- [ ] Language persists across screens

---

## 📝 Implementation Order

### Phase 1: Visual Redesign (High Priority)
1. Update POSTerminal.vue hardware frame design
2. Update button styles (green/red/yellow scheme)
3. Update screen background and contrast
4. Update all screen component styles

### Phase 2: Icon Migration (High Priority)
1. Import all required Lucide icons
2. Replace emojis in all 7 screen components
3. Adjust icon sizes and colors
4. Test rendering

### Phase 3: Translation System (High Priority)
1. Check i18n setup
2. Create translation JSON files
3. Update all screen components with translation keys
4. Test translations

### Phase 4: Language Switcher (Medium Priority)
1. Create TerminalLanguageSwitcher.vue
2. Integrate into POSTerminal.vue
3. Test switching functionality

### Phase 5: Testing & Polish (Medium Priority)
1. Complete visual testing
2. Complete functional testing
3. Complete flow testing
4. Fix any issues

---

## ✅ Success Criteria

- [ ] Terminal visually resembles a gas station payment terminal
- [ ] All emojis replaced with appropriate Lucide icons
- [ ] Complete German translation available
- [ ] Language switcher works smoothly
- [ ] All screens maintain functionality with new design
- [ ] High contrast and readability
- [ ] Professional and realistic appearance
- [ ] User can complete full transaction flow in both languages
