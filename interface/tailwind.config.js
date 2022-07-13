module.exports = {
  prefix: 'tw-',
  corePlugins: {
    preflight: false,
  },
  content: ['index.html','./src/**/*.{js,jsx,ts,tsx,vue,html}'],
  theme: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
