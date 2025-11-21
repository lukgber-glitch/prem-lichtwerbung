# Omnicom-Inspired Design System
## Premium Minimal Aesthetic for Prem-Lichtwerbung

This style guide documents the design system transformation inspired by Omnicom Group's ultra-minimal black/white aesthetic, featuring sophisticated animations, bold typography, and cinematic scroll effects.

---

## 1. COLOR PALETTE

### Primary Colors
- **Pure Black**: `#000000` - Primary brand color, headlines, UI elements
- **Pure White**: `#FFFFFF` - Background, inverse text
- **Muted Teal**: `#0F766E` - Accent color (use sparingly for subtle CTAs only)

### Text Colors
- **Text Primary**: `#000000` - Main headlines and body text on light backgrounds
- **Text Muted**: `#737373` - Secondary text, captions, labels (use sparingly)

### Surface Colors
- **Background**: `#FFFFFF` - Primary background
- **Surface**: `#FAFAFA` - Subtle surface variation (use minimally)
- **Surface Alt**: `#F5F5F5` - Alternative surface (use minimally)

### Usage Rules
- **High Contrast Only**: Pure black vs pure white - no grays except for muted text
- **No Color Decoration**: Eliminate yellows, blues, reds, greens from UI
- **Monochromatic Images**: All imagery should be black/white or high contrast
- **WCAG AAA Compliance**: Maintain 7:1+ contrast ratio

---

## 2. TYPOGRAPHY

### Font Families
- **Headings**: `'Outfit', 'Inter', sans-serif` - Bold, geometric, modern
- **Body**: `'Inter', system-ui, sans-serif` - Clean, readable, professional

### Heading Scales
- **H1 (Hero Headlines)**
  - Desktop: `96px` / line-height: `1.1` / weight: `900` / letter-spacing: `-0.02em`
  - Tablet: `72px` / line-height: `1.1` / weight: `900`
  - Mobile: `48px` / line-height: `1.1` / weight: `900`
  - Max 5-7 words per headline
  - Center-aligned or asymmetric placement

- **H2 (Section Titles)**
  - Desktop: `64px` / line-height: `1.2` / weight: `800`
  - Tablet: `48px` / line-height: `1.2` / weight: `800`
  - Mobile: `36px` / line-height: `1.2` / weight: `800`
  - Left-aligned or asymmetric
  - Max-width: 60% of container

- **H3 (Subsections)**
  - Desktop: `48px` / line-height: `1.3` / weight: `700`
  - Tablet: `36px` / line-height: `1.3` / weight: `700`
  - Mobile: `28px` / line-height: `1.3` / weight: `700`
  - Use sparingly, only when necessary

- **H4 (Minor Headings)**
  - Desktop: `32px` / line-height: `1.4` / weight: `600`
  - Tablet: `28px` / line-height: `1.4` / weight: `600`
  - Mobile: `24px` / line-height: `1.4` / weight: `600`

### Body Text
- **Large Body**
  - Desktop: `20px` / line-height: `1.6` / weight: `300`
  - Tablet: `18px` / line-height: `1.6` / weight: `300`
  - Mobile: `16px` / line-height: `1.6` / weight: `300`
  - Max-width: `600px` (for readability)
  - Always left-aligned, never centered

- **Regular Body**
  - Desktop: `18px` / line-height: `1.6` / weight: `300`
  - Tablet: `16px` / line-height: `1.6` / weight: `300`
  - Mobile: `15px` / line-height: `1.6` / weight: `300`

- **Small Text (Captions, Labels)**
  - Desktop: `14px` / line-height: `1.5` / weight: `300`
  - Color: `#737373` (muted gray)
  - Use for disclaimers, captions, metadata only

### Typography Rules
- **Font Weight Extremes**: Use only 300 (ultra-light) or 900 (ultra-bold) - avoid 400, 500, 600
- **Generous Line Height**: Body text 1.6+, headlines 1.1-1.3
- **Generous Spacing**: 40px+ between paragraphs
- **No Uppercase**: Use sentence case throughout
- **No Centered Body Text**: Always left-align body copy
- **No Text Decoration**: Except hover underlines on links

---

## 3. SPACING SYSTEM

### Container Widths
- **Max Container**: `1400px`
- **Content Max Width**: `1200px`
- **Text Max Width**: `600px` (for body copy)

### Section Spacing
- **Section Padding Y**: `200px` (desktop), `120px` (tablet), `80px` (mobile)
- **Section Padding X**: `120px` (desktop), `60px` (tablet), `24px` (mobile)

### Element Spacing
Use multiples of `40px` for all spacing:
- **Micro**: `8px`, `16px` (internal component spacing)
- **Small**: `40px` (between related elements)
- **Medium**: `80px` (between sections of content)
- **Large**: `120px` (between major sections)
- **XLarge**: `160px`, `200px` (hero sections, dramatic spacing)

### Tailwind Spacing Extensions
- `spacing-18`: `4.5rem` (72px)
- `spacing-88`: `22rem` (352px)
- `spacing-100`: `25rem` (400px)
- `spacing-128`: `32rem` (512px)
- `spacing-144`: `36rem` (576px)

---

## 4. LAYOUT PRINCIPLES

### Grid System
- **12-Column Grid** with wide gutters (40px+)
- **Asymmetric Layouts**: Intentionally break the grid
- **Floating Elements**: Position elements outside traditional grid boundaries
- **80% Whitespace Rule**: Each section should be 80%+ empty space

### Composition Rules
- **Full-Bleed Images**: Images extend to viewport edges
- **Generous Padding**: 100px+ on all sides of major sections
- **Asymmetric Balance**: Avoid centered, symmetric layouts
- **One Focus Per Section**: Single powerful element or message
- **Breathing Room**: Never crowd elements together

---

## 5. COMPONENTS

### Buttons

#### Ghost Button (Primary Style)
```
- Border: 2px solid currentColor
- Background: transparent
- Padding: 16px 48px
- Font: 16px / weight 600 / uppercase letter-spacing 0.1em
- Hover: Invert colors (black bg → white text, or vice versa)
- Transition: 500ms ease
- No shadows, no gradients
```

#### Minimal CTA
```
- Border: 1px solid currentColor
- Background: transparent
- Minimal padding: 12px 32px
- Hover: Subtle opacity change to 0.8
```

### Cards
```
- No borders by default
- No shadows
- No background (transparent)
- Content floats on whitespace
- Revealed on scroll with fade-in
- Hover: Subtle 1px border appears
```

### Images
```
- Full-bleed or oversized presentation
- Monochrome or desaturated
- High contrast always
- Cinematic aspect ratios: 21:9, 16:9
- No rounded corners (sharp edges)
```

### Form Inputs
```
- Border: 1px solid #000 or #737373
- Background: transparent
- Padding: 16px 20px
- Focus: 2px border, no shadow
- Label: floating or inline, 14px weight 600
```

---

## 6. ANIMATIONS & TRANSITIONS

### Timing
- **Duration**: 800ms - 1200ms (slower, more sophisticated)
- **Easing**: `cubic-bezier(0.4, 0.0, 0.2, 1)` (smooth, elegant)
- **No Bounce**: Avoid elastic or bouncy effects

### Scroll-Triggered Animations
```javascript
- Fade-in: opacity 0 → 1
- Slide-up: translateY(100px) → translateY(0)
- Stagger: 0.1s - 0.2s delay between elements
- Trigger: When element reaches 80% viewport
```

### Parallax Effects
```
- Subtle depth: 0.1 - 0.3 speed multiplier
- Applied to background images and decorative elements
- Not applied to text (readability)
- Smooth scrub animation
```

### Hover States
```
- Links: Underline draws left-to-right (500ms)
- Buttons: Background color inverts (500ms)
- Images: Slight scale 1.05 or opacity 0.9 (800ms)
- Cards: Subtle border appears (500ms)
```

### Micro-interactions
```
- Page load: Hero fades in over 1200ms
- Scroll: Smooth with momentum (0.8x speed)
- Navigation: Fade transitions (600ms)
- Modal: Scale from 0.95 + fade (800ms)
```

---

## 7. IMAGERY GUIDELINES

### Photography Style
- **Monochrome Preferred**: Black and white or single-tone
- **High Contrast**: Deep blacks, bright whites
- **Dramatic Lighting**: Cinematic quality with strong shadows
- **Minimal Subjects**: Single focus, lots of negative space
- **Professional Quality**: 4K resolution minimum

### Image Types

#### Hero Backgrounds
- Abstract light rays, minimal compositions
- Signage installations with dramatic lighting
- Architectural shots at night with glowing elements

#### Product Photography
- Pure white or pure black backgrounds
- Studio lighting with minimal shadows
- Extreme close-ups showing detail
- Floating presentation (no surfaces visible)

#### Installation Shots
- Before/after transformations
- Silhouettes of workers with backlighting
- Wide architectural shots showing context

#### Abstract Concepts
- Light particles and geometric patterns
- 3D renders with minimal elements
- Museum-quality art installation aesthetics

---

## 8. VIDEO SPECIFICATIONS

### Technical Requirements
- **Resolution**: 1080p minimum, 4K preferred
- **Format**: MP4 (H.264 codec)
- **Duration**: 10-30 seconds, seamless loops
- **Audio**: None (silent) or subtle ambient sound
- **File Size**: Optimized for web (<5MB for background videos)

### Visual Style
- **Monochrome or Desaturated**: Match photo aesthetic
- **Subtle Motion**: Slow, elegant movements
- **No Fast Cuts**: Smooth, continuous shots
- **Cinematic Quality**: Professional color grading

### Implementation
```html
<video autoplay muted loop playsinline>
  <source src="video.mp4" type="video/mp4">
</video>
```
- Autoplay without controls
- Muted for autoplay compliance
- Loop seamlessly
- Reduced opacity (60-80%) when used as background

---

## 9. RESPONSIVE BEHAVIOR

### Breakpoints
- **Mobile**: < 640px
- **Tablet**: 640px - 1024px
- **Desktop**: > 1024px
- **Large Desktop**: > 1400px

### Scaling Rules

#### Typography
- Headlines scale down proportionally (50-70% on mobile)
- Body text maintains readability (minimum 15px)
- Line height increases slightly on mobile (1.7+)

#### Spacing
- Section padding scales down: 200px → 120px → 80px
- Element spacing scales: 80px → 40px → 24px
- Maintain breathing room even on mobile

#### Layout
- Stack asymmetric layouts vertically on mobile
- Full-bleed images remain full-bleed
- Single column content on mobile
- Touch targets minimum 44px height

#### Animations
- Disable parallax on mobile (performance)
- Reduce animation duration by 30% on mobile
- Simplify scroll effects
- Maintain fade-ins only

---

## 10. ACCESSIBILITY

### Color Contrast
- **WCAG AAA**: 7:1+ contrast ratio throughout
- Pure black on white achieves 21:1 ratio
- Muted gray #737373 achieves 4.6:1 (for secondary text only)

### Typography
- **Readable Sizes**: Minimum 15px on mobile, 16px desktop
- **Clear Hierarchy**: Distinct size differences between levels
- **Generous Spacing**: Enhances readability for all users

### Interactive Elements
- **Focus States**: Visible 2px outline on all interactive elements
- **Touch Targets**: Minimum 44x44px for mobile
- **Keyboard Navigation**: All actions accessible via keyboard
- **Screen Readers**: Proper ARIA labels and semantic HTML

### Motion
- **Respect prefers-reduced-motion**: Disable animations for users who prefer reduced motion
- **No Essential Motion**: Animations are decorative only, not required for understanding

---

## 11. PERFORMANCE TARGETS

### Core Web Vitals
- **LCP (Largest Contentful Paint)**: < 2.5s
- **FID (First Input Delay)**: < 100ms
- **CLS (Cumulative Layout Shift)**: < 0.1

### Lighthouse Scores
- **Performance**: 90+
- **Accessibility**: 100
- **Best Practices**: 95+
- **SEO**: 100

### Optimization Strategies
- Lazy load images below fold
- Preload critical fonts
- Optimize video file sizes
- Use WebP format for images
- Implement code splitting
- Minimize CSS/JS bundles

---

## 12. DESIGN PRINCIPLES SUMMARY

### The Five Pillars of Omnicom-Inspired Design

1. **Minimalism**: Less is exponentially more - embrace extreme whitespace
2. **Contrast**: Pure black vs pure white - no middle ground
3. **Typography**: Massive bold headlines, whisper-light body copy
4. **Motion**: Smooth, sophisticated, cinematic animations
5. **Quality**: Premium materials, professional execution, attention to detail

### What to Avoid
- ❌ Colorful UI elements
- ❌ Decorative icons in circles
- ❌ Drop shadows and gradients
- ❌ Rounded corners (except minimal 4px)
- ❌ Busy layouts with multiple focal points
- ❌ Bouncy or playful animations
- ❌ Conventional symmetric grids
- ❌ Multiple buttons or CTAs per section
- ❌ Small, timid typography
- ❌ Cramped spacing

### What to Embrace
- ✅ Generous whitespace (80%+ empty)
- ✅ Bold, confident typography
- ✅ High-contrast imagery
- ✅ Asymmetric, floating layouts
- ✅ Smooth, elegant transitions
- ✅ Minimal, invisible UI
- ✅ One powerful message per section
- ✅ Professional, corporate aesthetic
- ✅ Cinematic quality throughout
- ✅ Sophisticated simplicity

---

**Version**: 1.0  
**Last Updated**: 2025-11-21  
**Maintained By**: Prem-Lichtwerbung Design Team
