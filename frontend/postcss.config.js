const production = !process.env.ROLLUP_WATCH;
const purgecss = require("@fullhuman/postcss-purgecss");

module.exports = {
  plugins: [
    require("postcss-import")(),
    require("tailwindcss")("./tailwind.js"),
    require("autoprefixer"),
    production &&
      purgecss({
        content: ["./src/**/*.svelte", "./src/**/*.html"],
        defaultExtractor: (content) => content.match(/[A-Za-z0-9-_:/]+/g) || [],
        whitelistPatterns: [
          // for JS ripple
          /ripple/,
        ],
      }),
  ],
};
