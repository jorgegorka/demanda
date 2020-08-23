module.exports = {
  theme: {
    extend: {
      fontFamily: {
        display: ["Open Sans", "sans-serif"],
        sans: ["Lato", "Helvetica", "Arial", "sans-serif"],
      },
    },
  },
  variants: {
    backgroundColor: ["even", "odd", "hover", "focus"],
  },
  plugins: [require("@tailwindcss/ui")],
};
