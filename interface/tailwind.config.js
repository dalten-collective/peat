module.exports = {
  prefix: 'tw-',
  corePlugins: {
    preflight: false,
  },
  content: ['index.html','./src/**/*.{js,jsx,ts,tsx,vue,html}'],
  theme: {
    extend: {
      colors: {
        background: '#ffffff',
        surface: '#f0efef',
        primary: '#5e5a4f',
        'primary-darken-1': '#4c4842',
        secondary: '#c6c6c5',
        'secondary-darken-1': '#bcb1a1',
        success: '#10B981',
        info: '#3B82F6',
        error: '#E11D48',
        warning: '#FBBF24',
      },
      textColor: {
      },
      fontFamily: {
        silom: ["silom"],
        sans: ['silom'],
      },
      borderRadius: {
        DEFAULT: '2.5px',
        'peat': '2.5px',
      },
      borderWidth: {
        DEFAULT: '1.33px',
        'peat': '1.33px',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
