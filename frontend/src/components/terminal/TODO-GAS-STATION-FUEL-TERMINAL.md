# Gas Station Fuel Terminal - Complete TODO

## 🎯 Goal
Transform the POS terminal into a realistic gas station fuel pump payment terminal where customers can:
- Select their gas pump number
- Choose fuel type (Diesel, Petrol, Super, etc.)
- Select payment method and timing
- Experience a complete fuel purchase flow with German language support

---

## 🛣️ Terminal Flow Design

### Complete User Journey
```
1. Welcome Screen
   ↓
2. Payment Timing Selection (Pay Now / Pay After Fueling)
   ↓
3. Pump Number Selection (1-12 grid)
   ↓
4. Fuel Type Selection (Diesel, Super, Super Plus, E10)
   ↓
5. Amount Selection (Fill Tank / Enter € Amount / Enter Liters)
   ↓
6. Payment Method (Card, Cash, Mobile) [if Pay Now]
   ↓
7. Payment Processing & Pump Authorization
   ↓
8. Fueling In Progress (animated progress)
   ↓
9. Fueling Complete
   ↓
10. Payment (if Pay After)
    ↓
11. Receipt & Success
```

---

## 📱 Screen Components

### 1. TerminalWelcome.vue (REDESIGN)
**Purpose:** Gas station welcome screen

**Content:**
- [ ] Gas station logo/branding
- [ ] "Welcome to Prem Tankstelle" message
- [ ] "Touch to begin fueling" prompt
- [ ] Current fuel prices display (Diesel, Super, Super Plus)
- [ ] Language switcher (DE/EN)
- [ ] Operating hours notice

**Icons (Lucide):**
- [ ] `<Fuel />` - Main gas pump icon (80px)
- [ ] `<Car />` - Vehicle icon
- [ ] `<Clock />` - Hours icon
- [ ] `<Languages />` - Language switcher

**Translations:**
- EN: "Welcome to Prem Service Station"
- DE: "Willkommen bei Prem Tankstelle"
- EN: "Touch to begin fueling"
- DE: "Berühren Sie zum Tanken"

---

### 2. TerminalPaymentTiming.vue (NEW)
**Purpose:** Choose when to pay (before or after fueling)

**Content:**
- [ ] Two large option cards
- [ ] "Pay Now" option (pre-authorize pump)
- [ ] "Pay After" option (traditional pump first, pay inside)
- [ ] Explanation text for each option
- [ ] Recommended badge on "Pay Now"

**Icons (Lucide):**
- [ ] `<CreditCard />` - Payment icon (64px)
- [ ] `<Fuel />` - Pump icon (64px)
- [ ] `<ArrowRight />` - Flow indicator

**Translations:**
- EN: "When would you like to pay?"
- DE: "Wann möchten Sie bezahlen?"
- EN: "Pay Now" / "Pay After Fueling"
- DE: "Jetzt bezahlen" / "Nach dem Tanken bezahlen"
- EN: "Pre-authorize your card, pump automatically stops at approved amount"
- DE: "Karte vorautorisieren, Zapfsäule stoppt automatisch bei genehmigtem Betrag"

---

### 3. TerminalPumpSelection.vue (NEW)
**Purpose:** Select gas pump number

**Content:**
- [ ] Grid of pump numbers (1-12)
- [ ] Large clickable pump number buttons (4x3 grid)
- [ ] Visual indicators (available, in use, out of order)
- [ ] "Which pump are you at?" header
- [ ] Pump location map (optional visual)

**Icons (Lucide):**
- [ ] `<Circle />` - Pump number background
- [ ] `<CheckCircle />` - Selected pump
- [ ] `<XCircle />` - Unavailable pump
- [ ] `<MapPin />` - Location indicator

**Translations:**
- EN: "Select Your Pump Number"
- DE: "Wählen Sie Ihre Zapfsäulennummer"
- EN: "Which pump are you at?"
- DE: "An welcher Zapfsäule sind Sie?"
- EN: "Available" / "In Use" / "Out of Order"
- DE: "Verfügbar" / "In Benutzung" / "Außer Betrieb"

---

### 4. TerminalFuelType.vue (NEW)
**Purpose:** Choose fuel type

**Content:**
- [ ] Large fuel type cards with colors
- [ ] Diesel (black/dark gray card)
- [ ] Super (green card)
- [ ] Super Plus (yellow card)
- [ ] E10 (light green card)
- [ ] Price per liter display for each
- [ ] Fuel specifications (octane rating, bio content)

**Icons (Lucide):**
- [ ] `<Droplet />` - Fuel droplet icon (48px)
- [ ] `<Zap />` - Performance indicator for premium
- [ ] `<Leaf />` - Eco indicator for E10
- [ ] `<Info />` - Information icon

**Colors & Labels:**
- Diesel: Black background, white text, "DIESEL"
- Super (95): Green background, "SUPER 95"
- Super Plus (98): Yellow background, "SUPER PLUS 98"
- E10: Light green, "SUPER E10"

**Translations:**
- EN: "Select Fuel Type"
- DE: "Kraftstoffart wählen"
- EN: "Diesel" / "Super" / "Super Plus" / "E10"
- DE: "Diesel" / "Super" / "Super Plus" / "E10"
- EN: "per liter"
- DE: "pro Liter"

---

### 5. TerminalAmountSelection.vue (NEW)
**Purpose:** Choose how much fuel to purchase

**Content:**
- [ ] Three main options
- [ ] "Fill Tank" button (most common)
- [ ] "Enter Amount (€)" with number pad
- [ ] "Enter Liters" with number pad
- [ ] Pre-set amount buttons (€20, €30, €50, €75, €100)
- [ ] Maximum authorization notice

**Icons (Lucide):**
- [ ] `<Gauge />` - Full tank icon (48px)
- [ ] `<Euro />` - Currency icon
- [ ] `<Droplet />` - Liters icon
- [ ] `<Calculator />` - Number pad indicator

**Number Pad:**
- [ ] 0-9 buttons
- [ ] Decimal point
- [ ] Clear/Delete
- [ ] Confirm

**Translations:**
- EN: "How much would you like?"
- DE: "Wie viel möchten Sie?"
- EN: "Fill Tank"
- DE: "Volltanken"
- EN: "Enter Amount (€)"
- DE: "Betrag eingeben (€)"
- EN: "Enter Liters"
- DE: "Liter eingeben"
- EN: "Quick Select"
- DE: "Schnellauswahl"

---

### 6. TerminalPaymentMethod.vue (UPDATE)
**Purpose:** Select payment method

**Current emojis to replace:**
- [ ] 💳 → `<CreditCard />` (64px)
- [ ] 💵 → `<Banknote />` (64px)
- [ ] 📱 → `<Smartphone />` (64px)
- [ ] 🔒 → `<Lock />` (20px)

**Update context:**
- [ ] Change "Card Payment" to "Debit/Credit Card"
- [ ] Change "Cash Payment" to "Cash (Pay Inside)"
- [ ] Update security message for gas station context

**Translations:**
- EN: "Select Payment Method"
- DE: "Zahlungsmethode wählen"
- EN: "Debit/Credit Card"
- DE: "Giro-/Kreditkarte"
- EN: "Cash (Pay Inside)"
- DE: "Bargeld (an der Kasse)"

---

### 7. TerminalProcessing.vue (UPDATE)
**Purpose:** Authorizing pump and processing payment

**Current emojis to replace:**
- [ ] 💳 → `<CreditCard />` with pulse animation (80px)
- [ ] Spinner → `<Loader2 />` with spin animation (60px)
- [ ] ⏳ → `<Clock />` (20px)
- [ ] ✓ → `<Check />` (20px)
- [ ] 🔒 → `<Lock />` (20px)

**Update messages:**
- [ ] "Verifying payment method" → "Zahlungsmethode wird überprüft"
- [ ] "Authorizing pump" → "Zapfsäule wird autorisiert" (NEW)
- [ ] "Activating fuel flow" → "Kraftstofffluss wird aktiviert" (NEW)
- [ ] "Ready to pump" → "Bereit zum Tanken" (NEW)

**Translations:**
- EN: "Authorizing Pump..."
- DE: "Zapfsäule wird autorisiert..."
- EN: "Please wait, pump will activate shortly"
- DE: "Bitte warten, Zapfsäule wird gleich aktiviert"

---

### 8. TerminalFueling.vue (NEW)
**Purpose:** Show fueling in progress

**Content:**
- [ ] Large animated fuel pump icon
- [ ] Real-time liter counter (animated)
- [ ] Real-time euro counter (animated)
- [ ] Progress bar or fuel gauge animation
- [ ] "Fueling in Progress" message
- [ ] "Do not remove nozzle" warning
- [ ] Current price per liter
- [ ] Estimated completion time

**Icons (Lucide):**
- [ ] `<Fuel />` - Pump icon with animation (100px)
- [ ] `<Gauge />` - Fuel gauge (64px)
- [ ] `<TrendingUp />` - Counter animation
- [ ] `<AlertCircle />` - Warning icon

**Animation:**
- [ ] Fuel gauge filling up
- [ ] Droplets falling animation
- [ ] Numbers incrementing
- [ ] Pulsing "in progress" indicator

**Translations:**
- EN: "Fueling in Progress"
- DE: "Tankvorgang läuft"
- EN: "Do Not Remove Nozzle"
- DE: "Zapfpistole nicht entfernen"
- EN: "Liters Dispensed"
- DE: "Getankte Liter"
- EN: "Total Amount"
- DE: "Gesamtbetrag"

---

### 9. TerminalFuelingComplete.vue (NEW)
**Purpose:** Notify fueling is complete

**Content:**
- [ ] "Fueling Complete" message
- [ ] Final liter amount
- [ ] Final euro amount
- [ ] "Please replace nozzle" instruction
- [ ] Auto-advance to payment/receipt after 5 seconds
- [ ] Skip button

**Icons (Lucide):**
- [ ] `<CheckCircle />` - Completion checkmark (80px)
- [ ] `<Fuel />` - Pump icon
- [ ] `<ArrowRight />` - Continue arrow

**Translations:**
- EN: "Fueling Complete"
- DE: "Tankvorgang abgeschlossen"
- EN: "Please replace nozzle and close fuel cap"
- DE: "Bitte Zapfpistole zurückhängen und Tankdeckel schließen"
- EN: "Total Liters"
- DE: "Liter gesamt"

---

### 10. TerminalSuccess.vue (UPDATE - Fuel Receipt)
**Purpose:** Show fuel purchase receipt

**Current emojis to replace:**
- [ ] ✓ → `<CheckCircle />` (80px)
- [ ] 🏪 → `<Store />` or `<Fuel />` (32px)
- [ ] 📧 → `<Mail />` (20px)
- [ ] 🎉 → `<Sparkles />` (20px)

**Update receipt content:**
- [ ] Station name and location
- [ ] Date and time
- [ ] Pump number
- [ ] Fuel type
- [ ] Liters dispensed
- [ ] Price per liter
- [ ] Total amount
- [ ] Payment method
- [ ] Transaction ID

**Translations:**
- EN: "Thank you for fueling"
- DE: "Vielen Dank fürs Tanken"
- EN: "Pump Number"
- DE: "Zapfsäule Nr."
- EN: "Fuel Type"
- DE: "Kraftstoffart"
- EN: "Liters"
- DE: "Liter"
- EN: "Price per Liter"
- DE: "Preis pro Liter"

---

### 11. TerminalError.vue (UPDATE)
**Purpose:** Handle errors specific to fuel terminal

**Current emojis to replace:**
- [ ] ❌ → `<XCircle />` (80px)
- [ ] 🔄 → `<RotateCw />` (20px)
- [ ] ✕ → `<X />` (20px)
- [ ] 📞 → `<Phone />` (20px)
- [ ] ℹ️ → `<AlertTriangle />` (20px)

**Update error types:**
- [ ] Pump authorization failed
- [ ] Pump malfunction
- [ ] Payment declined
- [ ] Fuel flow error
- [ ] Emergency stop activated

**Translations:**
- EN: "Pump Authorization Failed"
- DE: "Zapfsäulenfreigabe fehlgeschlagen"
- EN: "Please try again or see attendant"
- DE: "Bitte erneut versuchen oder Personal kontaktieren"

---

## 🎨 Visual Design - Gas Station Theme

### Terminal Hardware (POSTerminal.vue)
- [ ] Industrial gray/beige casing (not sleek black)
- [ ] Weathered/outdoor-rated appearance
- [ ] Large, chunky bezels
- [ ] Prominent card reader slot (horizontal, like gas stations)
- [ ] Wide receipt printer slot
- [ ] Large LED status lights (red/yellow/green)
- [ ] Emergency stop button (red, prominent)
- [ ] Help/Call button
- [ ] Keypad for PIN entry (physical button style)

### Color Scheme
- [ ] Primary action: Bright green (#22c55e) - "OK", "Confirm", "Start"
- [ ] Cancel/Stop: Bright red (#ef4444) - "Cancel", "Emergency Stop"
- [ ] Back/Secondary: Bright yellow (#fbbf24) - "Back", "Change"
- [ ] Screen background: Dark gray (#1f2937) or industrial beige (#f5f5dc)
- [ ] Text: High contrast black or white
- [ ] Fuel type colors: Black (Diesel), Green (Super), Yellow (Super Plus), Light Green (E10)

### Typography
- [ ] Large, bold sans-serif fonts (Arial, Helvetica)
- [ ] Minimum 18px for body text
- [ ] Minimum 24px for buttons
- [ ] Minimum 32px for headings
- [ ] All-caps for critical actions

### Buttons
- [ ] Minimum 80px height
- [ ] Wide buttons (full width or 48% for side-by-side)
- [ ] 3D effect with visible borders and shadows
- [ ] Chunky, tactile appearance
- [ ] Icon + text labels
- [ ] Glove-friendly touch targets (80px+ spacing)

---

## 🔄 Icon Migration (Complete List)

### Import Required Lucide Icons
```typescript
import {
  Fuel,           // Gas pump
  Car,            // Vehicle
  CreditCard,     // Card payment
  Banknote,       // Cash payment
  Smartphone,     // Mobile payment
  Droplet,        // Fuel droplet / liters
  Gauge,          // Fuel gauge / tank
  Euro,           // Currency
  Calculator,     // Number pad
  Circle,         // Pump number buttons
  CheckCircle,    // Success / completion
  XCircle,        // Error / unavailable
  MapPin,         // Location
  Zap,            // Performance / premium
  Leaf,           // Eco / E10
  Info,           // Information
  Clock,          // Time / hours
  Languages,      // Language switcher
  ArrowRight,     // Continue / next
  Loader2,        // Loading spinner
  Check,          // Checkmark
  Lock,           // Security
  TrendingUp,     // Counter animation
  AlertCircle,    // Warning
  AlertTriangle,  // Error details
  RotateCw,       // Retry
  X,              // Close / cancel
  Phone,          // Support
  Store,          // Station
  Mail,           // Email receipt
  Sparkles,       // Bonus / savings
  Package         // Items (if needed)
} from 'lucide-vue-next'
```

---

## 🌍 Translation System

### File Structure
```
frontend/src/locales/
  ├── terminal-en.json
  └── terminal-de.json
```

### Translation Keys Structure
```json
{
  "terminal": {
    "common": {
      "continue": "Continue",
      "back": "Back",
      "cancel": "Cancel",
      "confirm": "Confirm"
    },
    "welcome": { ... },
    "paymentTiming": { ... },
    "pumpSelection": { ... },
    "fuelType": { ... },
    "amountSelection": { ... },
    "paymentMethod": { ... },
    "processing": { ... },
    "fueling": { ... },
    "fuelingComplete": { ... },
    "success": { ... },
    "error": { ... }
  }
}
```

### Implementation
- [ ] Create terminal-en.json with all English strings
- [ ] Create terminal-de.json with all German translations
- [ ] Import `useI18n` in each component
- [ ] Replace all hardcoded strings with `t('terminal.section.key')`
- [ ] Test language switching

---

## 🔘 Language Switcher Component

### TerminalLanguageSwitcher.vue (NEW)
- [ ] Create component file
- [ ] Position in top-right corner of terminal screen
- [ ] Toggle button with flags: 🇩🇪 DE | 🇬🇧 EN
- [ ] Or use Lucide `<Languages />` icon with dropdown
- [ ] Chunky button style matching terminal design
- [ ] Persist language choice in localStorage
- [ ] Update all screens immediately on change

### Integration
- [ ] Add to POSTerminal.vue header area
- [ ] Make always visible (sticky position)
- [ ] Ensure it works on all screens
- [ ] Style to match gas station terminal aesthetic

---

## 🧪 Testing Checklist

### Flow Testing
- [ ] Welcome → Payment Timing → Pump → Fuel Type → Amount → Payment → Processing → Fueling → Complete → Receipt (EN)
- [ ] Same flow in German (DE)
- [ ] "Pay After" flow variation
- [ ] Error handling at each step
- [ ] Back button navigation works correctly
- [ ] Language switching persists across screens

### Functional Testing
- [ ] All Lucide icons render correctly
- [ ] Pump selection grid shows 12 pumps
- [ ] Fuel type cards display with correct colors
- [ ] Number pad works for amount entry
- [ ] Fueling animation plays smoothly
- [ ] Receipt shows correct fuel data
- [ ] Language switcher works on all screens

### Visual Testing
- [ ] Terminal looks like outdoor gas station terminal
- [ ] Buttons are large and chunky
- [ ] Colors are high contrast
- [ ] Text is easily readable
- [ ] Touch targets are appropriately sized
- [ ] Hardware details look realistic

---

## 📝 Implementation Order

### Phase 1: New Screen Components (High Priority)
1. Create TerminalPaymentTiming.vue
2. Create TerminalPumpSelection.vue
3. Create TerminalFuelType.vue
4. Create TerminalAmountSelection.vue
5. Create TerminalFueling.vue
6. Create TerminalFuelingComplete.vue

### Phase 2: Update Existing Screens (High Priority)
1. Redesign TerminalWelcome.vue (gas station context)
2. Update TerminalPaymentMethod.vue (gas station payments)
3. Update TerminalProcessing.vue (pump authorization)
4. Update TerminalSuccess.vue (fuel receipt)
5. Update TerminalError.vue (pump errors)

### Phase 3: Visual Redesign (High Priority)
1. Update POSTerminal.vue hardware frame (industrial design)
2. Implement new color scheme (green/red/yellow)
3. Update button styles (chunky, 3D effect)
4. Update typography (larger, bolder)

### Phase 4: Icon Migration (High Priority)
1. Import all required Lucide icons
2. Replace emojis in all components
3. Adjust sizes and colors
4. Test rendering

### Phase 5: Translation System (High Priority)
1. Create terminal-en.json
2. Create terminal-de.json
3. Update all components with useI18n
4. Replace hardcoded strings with translation keys
5. Test translations

### Phase 6: Language Switcher (Medium Priority)
1. Create TerminalLanguageSwitcher.vue
2. Integrate into POSTerminal.vue
3. Test switching functionality
4. Test persistence

### Phase 7: Update Navigation Flow (High Priority)
1. Update POSTerminal.vue state machine with new screens
2. Update screen navigation order
3. Add new screen types to TypeScript interfaces
4. Test complete flow

### Phase 8: Testing & Polish (Medium Priority)
1. Complete flow testing (EN & DE)
2. Complete functional testing
3. Complete visual testing
4. Fix any issues
5. Performance optimization

---

## ✅ Success Criteria

- [ ] Terminal functions as a complete gas station fuel payment terminal
- [ ] User can select pump number (1-12)
- [ ] User can choose fuel type (Diesel, Super, Super Plus, E10)
- [ ] User can select amount (fill tank, € amount, or liters)
- [ ] Fueling progress animation plays realistically
- [ ] Receipt shows fuel purchase details (liters, price/liter, total)
- [ ] All emojis replaced with appropriate Lucide icons
- [ ] Complete German translation available
- [ ] Language switcher works throughout flow
- [ ] Terminal looks like outdoor gas station terminal (industrial, weathered)
- [ ] High contrast, large buttons, glove-friendly
- [ ] User can complete full fuel purchase in both languages
- [ ] "Pay Now" and "Pay After" flows both work correctly
