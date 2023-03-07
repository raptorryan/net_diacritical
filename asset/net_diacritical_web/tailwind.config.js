const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: ["./js/**/*.js", "../../lib/*_web.ex", "../../lib/*_web/**/*.*ex"],
  plugins: [
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/forms"),
    require("@tailwindcss/line-clamp"),
    require("@tailwindcss/typography"),
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['"Inter var"', "Inter", ...defaultTheme.fontFamily.sans],
      },
    },
  },
};
