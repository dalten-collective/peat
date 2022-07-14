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
        surface: '#F5F5F4',
        primary: '#4c4842',
        'primary-darken-1': '#4c4842',
        secondary: '#dbd9ce',
        'secondary-darken-1': '#bcb1a1',
        success: '#10B981',
        info: '#3B82F6',
        error: '#E11D48',
        warning: '#FBBF24',
      },

    },
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
