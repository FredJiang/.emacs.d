module.exports = {
  'extends' : 'standard',
  'globals' : {
    'gLogger'          : true,
    'gConfigs'         : true,
    'gConfigsAct'      : true,
    'gConfigsOrder'    : true,
    'gProjectDir'      : true,
    'gProjectDirAct'   : true,
    'gProjectDirOrder' : true
  },
  'rules': {
    'space-before-function-paren': ['error', {
      'anonymous'  : 'always',
      'named'      : 'never',
      'asyncArrow' : 'always'
    }],
    'key-spacing': ['error', {
      'multiLine': {
        'beforeColon' : false,
        'afterColon'  : true
      },
      'align': {
        'beforeColon' : true,
        'afterColon'  : true,
        'on'          : 'colon'
      }
    }],
    'no-multi-spaces': ['error', {
      'exceptions': {
        'VariableDeclarator'   : true,
        'ImportDeclaration'    : true,
        'AssignmentExpression' : true
      }
    }],
    // "camelcase": 0, // disable the rule
    // "semi": 0 // disable the rule
    // "semi": [2, "never"]
    'semi': [2, 'always']
  }
};
