export default {
  content: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        'primary': '#FFB400',
        'accent': '#00D1FF',
        'background': '#0B0D1A',
        'surface': '#14172C',
        'surface-alt': '#1A1D34',
        'text-main': '#F3F4FA',
        'text-muted': '#9CA0C1',
      },
      fontFamily: {
        'sans': ['Inter', 'system-ui', 'sans-serif'],
        'heading': ['Space Grotesk', 'Inter', 'sans-serif'],
      },
      boxShadow: {
        'glow-subtle': '0 0 15px rgba(255, 180, 0, 0.3)',
        'glow-accent': '0 0 15px rgba(0, 209, 255, 0.3)',
      },
    },
  },
  plugins: [],
}
