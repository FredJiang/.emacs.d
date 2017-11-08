module.exports = {
  "extends": "standard",
  "globals": {
    "gLogger": true,
    "gProjectDir": true,
    "gProjectDirOrder": true,
    "gProjectDirActivity": true
  },
  "rules": {
    "space-before-function-paren": ["error", {
      "anonymous": "always",
      "named": "never",
      "asyncArrow": "always"
    }],
    // "camelcase": 0, // disable the rule
    // "semi": 0 // disable the rule
    // "semi": [2, "never"]
    "semi": [2, "always"]
  }
};
