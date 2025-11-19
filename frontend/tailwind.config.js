/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        'brand-blue': '#00D9FF',
        'brand-navy': '#0A1628',
        'brand-warm': '#FFF8E7',
        'brand-pink': '#FF006E',
        'brand-yellow': '#FFD600',
        'brand-gray-light': '#F5F5F5',
        'brand-gray-dark': '#2D3748',
      },
      fontFamily: {
        'sans': ['Inter', 'system-ui', 'sans-serif'],
        'accent': ['Orbitron', 'sans-serif'],
      },
      boxShadow: {
        'glow-blue': '0 0 20px rgba(0, 217, 255, 0.5)',
        'glow-pink': '0 0 20px rgba(255, 0, 110, 0.5)',
        'glow-yellow': '0 0 20px rgba(255, 214, 0, 0.5)',
      },
    },
  },
  plugins: [],
}
