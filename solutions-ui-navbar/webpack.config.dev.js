const HtmlWebPackPlugin = require("html-webpack-plugin");
module.exports = {
  mode: "development",
  devtool: "source-map",
  entry: "./index.js",
  module: {
    // ...
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
        },
      },
      {
        test: /\.mdx?$/,
        use: ["babel-loader", "@mdx-js/loader"],
      }
    ],
  },
  plugins: [
    new HtmlWebPackPlugin({
      template: "./index-template.html",
    }),
  ],
};
