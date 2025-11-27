export default {
  content: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        // Omnicom Group actual colors from omnicom-clone
        'primary': '#ab3930',
        'primary-dark': '#8b2821',
        'dark-bg': '#211b1c',
        'light-bg': '#f6f5f5',
        'gold': '#b08c65',
        // Standard grays
        'gray': {
          50: '#f9fafb',
          100: '#f3f4f6',
          200: '#e5e7eb',
          300: '#d1d5db',
          400: '#9ca3af',
          500: '#6b7280',
          600: '#4b5563',
          700: '#374151',
          800: '#1f2937',
          900: '#111827',
        }
      },
      fontFamily: {
        sans: ['Lato', 'system-ui', 'sans-serif'],
        serif: ['Merriweather', 'Georgia', 'serif'],
        heading: ['Lato', 'system-ui', 'sans-serif']
      },
      fontSize: {
        '7xl': ['5rem', { lineHeight: '1.1' }],
        '8xl': ['6rem', { lineHeight: '1.1' }],
        '9xl': ['7rem', { lineHeight: '1.1' }],
      },
      maxWidth: {
        'content': '1400px',
        'text': '1000px'
      },
      borderRadius: {
        'sm': '0.125rem',
        DEFAULT: '0rem',
      },
      transitionDuration: {
        '500': '500ms',
      },
      container: {
        center: true,
        padding: {
          DEFAULT: '1.5rem',
          sm: '2rem',
          lg: '4rem',
          xl: '5rem',
          '2xl': '6rem',
        },
      }
    },
  },
  plugins: [],
}
