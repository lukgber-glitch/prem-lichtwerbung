export default {
  content: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  theme: {
    colors: {
      'omnicom-red': '#AD342A',
      'omnicom-red-dark': '#8B2821',
      'omnicom-red-light': '#C64032',
      'omnicom-blue': '#0066CC',
      'omnicom-purple': '#6B3FA0',
      'omnicom-green': '#00A651',
      'omnicom-orange': '#FF6B35',
      'omnicom-teal': '#00A19A',
      'omnicom-black': '#000000',
      'omnicom-gray-900': '#1A1A1A',
      'omnicom-gray-800': '#2D2D2D',
      'omnicom-gray-700': '#4A4A4A',
      'omnicom-gray-600': '#6B6B6B',
      'omnicom-gray-400': '#9E9E9E',
      'omnicom-gray-300': '#CCCCCC',
      'omnicom-gray-200': '#E5E5E5',
      'omnicom-gray-100': '#F5F5F5',
      'omnicom-white': '#FFFFFF'
    },
    extend: {
      fontFamily: {
        sans: ['Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif'],
        heading: ['Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif']
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
