export default {
  content: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  theme: {
    colors: {
      'omnicom-black': '#0A0A0A',
      'omnicom-white': '#FAFAFA',
      'omnicom-gray': '#F5F5F5',
      'omnicom-text': '#1A1A1A',
      'omnicom-muted': '#666666',
      black: '#000000',
      white: '#FFFFFF',
      transparent: 'transparent',
      current: 'currentColor'
    },
    extend: {
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        heading: ['Inter', 'system-ui', 'sans-serif']
      },
      fontSize: {
        '7xl': ['5rem', { lineHeight: '1', letterSpacing: '-0.02em' }],
        '8xl': ['6rem', { lineHeight: '1', letterSpacing: '-0.03em' }],
        '9xl': ['8rem', { lineHeight: '1', letterSpacing: '-0.03em' }],
        '10xl': ['10rem', { lineHeight: '1', letterSpacing: '-0.04em' }]
      },
      spacing: {
        '18': '4.5rem',
        '88': '22rem',
        '100': '25rem',
        '128': '32rem'
      },
      maxWidth: {
        'content': '1400px',
        'text': '800px'
      },
      transitionDuration: {
        '800': '800ms',
        '1200': '1200ms'
      }
    },
  },
  plugins: [],
}
