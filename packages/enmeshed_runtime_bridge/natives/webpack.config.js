// Generated using webpack-cli https://github.com/webpack/webpack-cli

const path = require("path");

const isProduction = process.env.NODE_ENV == "production";

const config = {
  entry: "./dist/index.js",
  output: {
    path: path.resolve(__dirname, "../assets/"),
  },
  devServer: {
    open: true,
    host: "localhost",
  },
  plugins: [
    // Add your plugins here
    // Learn more about plugins from https://webpack.js.org/configuration/plugins/
  ],
  module: {
    rules: [
      {
        test: /\.(eot|svg|ttf|woff|woff2|png|jpg|gif)$/i,
        type: "asset",
      },

      // Add your rules for custom modules here
      // Learn more about loaders from https://webpack.js.org/loaders/
    ],
  },
  resolve: {
    extensions: [".tsx", ".ts", ".jsx", ".js", "..."],
  },
  externals: {
    lokijs: "loki",
    "@nmshd/consumption": "NMSHDConsumption",
    "@nmshd/content": "NMSHDContent",
    "@nmshd/transport": "NMSHDTransport",
    "@nmshd/crypto": "NMSHDCrypto",
    "@nmshd/runtime": "NMSHDRuntime",
    "@nmshd/app-runtime": "NMSHDAppRuntime",
    "@js-soft/ts-serval": "TSServal",
  },
};

module.exports = () => {
  if (isProduction) {
    config.mode = "production";
  } else {
    config.mode = "development";
  }
  return config;
};
