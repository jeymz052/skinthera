const config = {
  // The application uses authored CSS rather than Tailwind utilities. Running
  // the 400 KB legacy stylesheet through Tailwind's scanner exhausted the
  // codespace loader process, so PostCSS intentionally has no transforms.
  plugins: {},
};

export default config;
