export default {
  content: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  theme: {
    extend: {
      // Omnicom-Inspired Color Palette - Pure Black/White Minimal Aesthetic
      colors: {
        'primary': '#000000', // Pure Black
        'accent': '#0F766E', // Muted Teal (use sparingly for subtle CTAs)
        'background': '#FFFFFF', // Pure White
        'surface': '#FAFAFA', // Subtle surface variation (minimal use)
        'surface-alt': '#F5F5F5', // Alternative surface (minimal use)
        'text-main': '#000000', // Pure Black text
        'text-muted': '#737373', // Muted gray (use sparingly)
        'black': '#000000',
        'white': '#FFFFFF',
      },
      
      // Premium Font Families - Omnicom Style
      fontFamily: {
        'sans': ['Inter', 'system-ui', 'sans-serif'],
        'heading': ['Outfit', 'Inter', 'sans-serif'],
      },
      
      // Generous Spacing Scale - Extreme Whitespace
      spacing: {
        '18': '4.5rem',    // 72px
        '88': '22rem',     // 352px
        '100': '25rem',    // 400px
        '128': '32rem',    // 512px
        '144': '36rem',    // 576px
      },
      
      // Massive Font Sizes - Bold Typography
      fontSize: {
        '7xl': ['5rem', { lineHeight: '1.1' }],      // 80px
        '8xl': ['6rem', { lineHeight: '1.1' }],      // 96px
        '9xl': ['8rem', { lineHeight: '1.1' }],      // 128px
        '10xl': ['10rem', { lineHeight: '1.1' }],    // 160px
      },
      
      // Animation Timings - Sophisticated Slow Motion
      transitionDuration: {
        '800': '800ms',
        '1000': '1000ms',
        '1200': '1200ms',
      },
      
      // Custom Easing - Smooth Omnicom Motion
      transitionTimingFunction: {
        'omnicom': 'cubic-bezier(0.4, 0.0, 0.2, 1)',
      },
      
      // Max Width Constraints
      maxWidth: {
        'content': '1400px',
        'text': '600px',
      },
    },
  },
  plugins: [],
}
