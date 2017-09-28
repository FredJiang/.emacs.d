module.exports = {
  "extends": "standard",
  "globals": {
    "gLogger": true,
    "gProjectDir": true
  },
  "rules": {
    "space-before-function-paren": ["error", {
      "anonymous": "always",
      "named": "never",
      "asyncArrow": "always"
    }],
    // "camelcase": 0,
    // "semi": [2, "never"]
    // "semi": [2, "always"]
    // disable the rule
    "semi": 0
  }
};