export default {
  content: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        // Primary & Accent - Muted Professional Palette
        'primary': '#475569', // Muted slate-blue
        'accent': '#0F766E', // Sophisticated teal
        
        // Background & Surface (Light mode)
        'background': '#FAFAF9', // Soft warm white
        'surface': '#F5F5F4', // Light gray
        'surface-alt': '#E7E5E4', // Slightly darker gray
        
        // Text Colors
        'text-main': '#1E293B', // Dark slate
        'text-muted': '#64748B', // Medium gray
        
        // Utility Colors
        'success': '#059669', // Muted green
        'warning': '#D97706', // Muted amber
        'error': '#DC2626', // Muted red
        
        // Extended Brand Colors (backward compatibility)
        'brand-blue': '#475569',
        'brand-pink': '#0F766E',
        'brand-warm': '#64748B',
        'brand-navy': '#1E293B',
        'brand-gray-light': '#F5F5F4',
        'brand-yellow': '#D97706',
      },
      fontFamily: {
        'sans': ['Inter', 'system-ui', 'sans-serif'],
        'heading': ['Space Grotesk', 'Inter', 'sans-serif'],
        'accent': ['Space Grotesk', 'Inter', 'sans-serif'],
      },
      boxShadow: {
        // Minimal Glow for CTAs Only (Teal accent)
        'glow-cta': '0 0 24px rgba(15, 118, 110, 0.15), 0 0 12px rgba(15, 118, 110, 0.1)',
        
        // Shadow Scale (Professional, Subtle)
        'soft': '0 2px 8px rgba(0, 0, 0, 0.04), 0 1px 4px rgba(0, 0, 0, 0.02)',
        'card': '0 4px 12px rgba(0, 0, 0, 0.06), 0 2px 6px rgba(0, 0, 0, 0.04)',
        'elevated': '0 8px 24px rgba(0, 0, 0, 0.08), 0 4px 12px rgba(0, 0, 0, 0.06)',
        
        // Legacy glow effects (for backward compatibility, will be removed)
        'glow-sm': '0 0 24px rgba(15, 118, 110, 0.15), 0 0 12px rgba(15, 118, 110, 0.1)',
        'glow-md': '0 0 24px rgba(15, 118, 110, 0.15), 0 0 12px rgba(15, 118, 110, 0.1)',
        'glow-lg': '0 0 24px rgba(15, 118, 110, 0.15), 0 0 12px rgba(15, 118, 110, 0.1)',
        'glow-subtle': '0 0 24px rgba(15, 118, 110, 0.15), 0 0 12px rgba(15, 118, 110, 0.1)',
        'glow-accent': '0 0 24px rgba(15, 118, 110, 0.15), 0 0 12px rgba(15, 118, 110, 0.1)',
        'glow-pink': '0 0 24px rgba(15, 118, 110, 0.15), 0 0 12px rgba(15, 118, 110, 0.1)',
        'glow-blue': '0 0 24px rgba(15, 118, 110, 0.15), 0 0 12px rgba(15, 118, 110, 0.1)',
      },
    },
  },
  plugins: [],
}
