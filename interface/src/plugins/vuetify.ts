// Styles
import '@mdi/font/css/materialdesignicons.css'
import 'vuetify/styles'

// Vuetify
import { createVuetify, ThemeDefinition } from 'vuetify'

const peatTheme: ThemeDefinition = {
  dark: false,
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
}


export default createVuetify({
  // https://vuetifyjs.com/en/introduction/why-vuetify/#feature-guides
  theme: {
    defaultTheme: 'peatTheme',
    themes: {
      peatTheme
    }
  }
})
