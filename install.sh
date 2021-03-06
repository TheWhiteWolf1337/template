#!/usr/bin/env bash

set -e

Projects[0]='autoprefixer'
Projects[1]='eslint'
Projects[2]='eslint-plugin-prettier'
Projects[3]='eslint-config-prettier'
Projects[4]='events'
Projects[5]='google-closure-compiler'
Projects[6]='prettier'
Projects[7]='prettier-stylelint'
Projects[8]='stylelint'
Projects[9]='stylelint-config-idiomatic-order'
Projects[10]='tslint'
Projects[11]='tslint-config-prettier'
Projects[12]='tslint-plugin-prettier'
Projects[13]='typescript'

Gulp[0]='gulp'
Gulp[1]='gulp-connect'
Gulp[2]='gulp-cssnano'
Gulp[3]='gulp-gh-pages'
Gulp[4]='gulp-htmlmin'
Gulp[5]='gulp-image'
Gulp[6]='gulp-postcss'
Gulp[7]='gulp-prettier'
Gulp[8]='gulp-pretty-data'
Gulp[9]='gulp-purifycss'
Gulp[10]='gulp-sass'
Gulp[11]='gulp-sitemap'
Gulp[12]='gulp-string-replace'
Gulp[13]='gulp-stylelint'
Gulp[14]='gulp-tslint'
Gulp[15]='gulp-typescript'
Gulp[17]='gulp-webp'

if yarn -v /dev/null 2>&1; then

    yarn init

    for project in "${Projects[@]}"
    do
        list=$list" $project"
    done

    for gulp in "${Gulp[@]}"
    do
        list=$list" $gulp"
    done

	yarn add $list --save-dev

elif npm -v /dev/null 2>&1; then
    npm init

    for project in "${Projects[@]}"
    do
        list=$list" $project"
    done

    for gulp in "${Gulp[@]}"
    do
        list=$list" $gulp"
    done

	npm install $list --save-dev

else
    echo "Npm or yarn are required to utilize this template and to use javascript."
fi

mkdir -p src/sass
mkdir src/css
mkdir src/img
mkdir src/js
mkdir src/ts
touch src/ts/tsconfig.json
touch src/ts/tslint.json
echo "node_modules" > .gitignore
echo "$(curl -fsSL https://raw.githubusercontent.com/TheWhiteWolf1337/template/master/gulpfile.js)" > gulpfile.js
echo "$(curl -fsSL https://raw.githubusercontent.com/TheWhiteWolf1337/template/master/src/ts/tsconfig.json)" > src/ts/tsconfig.json
echo "$(curl -fsSL https://raw.githubusercontent.com/TheWhiteWolf1337/template/master/src/ts/tslint.json)" > src/ts/tslint.json

BADLINESCOUNT=1
ORIGINALFILE=$PWD/package.json
dd if=${ORIGINALFILE} of=${ORIGINALFILE}.tmp status=none bs=1 count=$(printf "$(stat --format=%s ${ORIGINALFILE}) - $(tail -n${BADLINESCOUNT} ${ORIGINALFILE} | wc -c)\n" | bc )
sed '${s/$/,/}' ${ORIGINALFILE}.tmp > ${ORIGINALFILE}.tmp.tmp
rm -rf ${ORIGINALFILE}.tmp
/bin/mv -f ${ORIGINALFILE}.tmp.tmp ${ORIGINALFILE}
cat >> package.json <<EOL
	"scripts": {
		"tslint": "tslint -c src/ts/tslint.json src/ts/*.ts"
	},
	"stylelint": {
		"extends": [
			"stylelint-config-idiomatic-order",
			"./node_modules/prettier-stylelint/config.js"
		],
		"rules": {
			"unit-whitelist": [
				"rem",
				"deg",
				"vh",
				"em",
				"px",
				"fr",
				"%",
				"s"
			],
			"string-quotes": "single"
		},
		"ignoreFiles": "./dist/css/main.css"
	},
	"eslintConfig": {
		"extends": [
			"prettier",
			"prettier/@typescript-eslint"
		],
		"plugins": [
			"prettier"
		],
		"env": {
			"browser": true,
			"node": true,
			"es6": true
		},
		"parserOptions": {
			"ecmaVersion": "2018",
			"sourceType": "module",
			"ecmaFeatures": {
				"arrowFunctions": true,
				"binaryLiterals": true,
				"blockBindings": true,
				"classes": true,
				"defaultParams": true,
				"destructuring": true,
				"forOf": true,
				"generators": true,
				"modules": true,
				"objectLiteralComputedProperties": true,
				"objectLiteralDuplicateProperties": true,
				"objectLiteralShorthandMethods": true,
				"objectLiteralShorthandProperties": true,
				"octalLiterals": true,
				"regexUFlag": true,
				"regexYFlag": true,
				"spread": true,
				"superInFunctions": true,
				"templateStrings": true,
				"unicodeCodePointEscapes": true,
				"globalReturn": true,
				"jsx": true
			}
		},
		"rules": {
			"prettier/prettier": "error",
			"comma-dangle": 2,
			"no-cond-assign": 2,
			"no-console": 0,
			"no-constant-condition": 2,
			"no-control-regex": 2,
			"no-debugger": 2,
			"no-dupe-args": 2,
			"no-dupe-keys": 2,
			"no-duplicate-case": 2,
			"no-empty": 2,
			"no-empty-character-class": 2,
			"no-ex-assign": 2,
			"no-extra-boolean-cast": 2,
			"no-extra-parens": 0,
			"no-extra-semi": 2,
			"no-func-assign": 2,
			"no-inner-declarations": 2,
			"no-invalid-regexp": 2,
			"no-irregular-whitespace": 2,
			"no-negated-in-lhs": 2,
			"no-obj-calls": 2,
			"no-regex-spaces": 2,
			"no-sparse-arrays": 2,
			"no-unreachable": 2,
			"use-isnan": 2,
			"valid-jsdoc": 2,
			"valid-typeof": 2,
			"block-scoped-var": 0,
			"complexity": 0,
			"consistent-return": 2,
			"curly": 2,
			"default-case": 2,
			"dot-notation": 2,
			"eqeqeq": 2,
			"guard-for-in": 2,
			"no-alert": 2,
			"no-caller": 2,
			"no-div-regex": 2,
			"no-else-return": 2,
			"no-eq-null": 2,
			"no-eval": 2,
			"no-extend-native": 2,
			"no-extra-bind": 2,
			"no-fallthrough": 2,
			"no-floating-decimal": 2,
			"no-implied-eval": 2,
			"no-iterator": 2,
			"no-labels": 2,
			"no-lone-blocks": 2,
			"no-loop-func": 2,
			"no-multi-spaces": 2,
			"no-multi-str": 2,
			"no-native-reassign": 2,
			"no-new": 2,
			"no-new-func": 2,
			"no-new-wrappers": 2,
			"no-octal": 2,
			"no-octal-escape": 2,
			"no-param-reassign": 2,
			"no-process-env": 2,
			"no-proto": 2,
			"no-redeclare": 2,
			"no-return-assign": 2,
			"no-script-url": 2,
			"no-self-compare": 2,
			"no-sequences": 2,
			"no-throw-literal": 2,
			"no-unused-expressions": 2,
			"no-void": 2,
			"no-warning-comments": [
				0,
				{
					"terms": [
						"todo",
						"fixme"
					],
					"location": "start"
				}
			],
			"no-with": 2,
			"radix": 2,
			"vars-on-top": 2,
			"wrap-iife": 2,
			"yoda": 2,
			"strict": 0,
			"no-catch-shadow": 2,
			"no-delete-var": 2,
			"no-label-var": 2,
			"no-shadow": 2,
			"no-shadow-restricted-names": 2,
			"no-undef": 2,
			"no-undef-init": 2,
			"no-undefined": 2,
			"no-unused-vars": 2,
			"no-use-before-define": 2,
			"indent": [
				2,
				"tab"
			],
			"brace-style": 1,
			"camelcase": 0,
			"comma-spacing": [
				1,
				{
					"before": false,
					"after": true
				}
			],
			"comma-style": [
				1,
				"last"
			],
			"consistent-this": [
				1,
				"_this"
			],
			"eol-last": 1,
			"func-names": 0,
			"func-style": 0,
			"key-spacing": [
				1,
				{
					"beforeColon": false,
					"afterColon": true
				}
			],
			"max-nested-callbacks": [
				1,
				3
			],
			"new-cap": [
				1,
				{
					"newIsCap": true,
					"capIsNew": false
				}
			],
			"new-parens": 1,
			"newline-after-var": 0,
			"no-array-constructor": 1,
			"no-inline-comments": 0,
			"no-lonely-if": 1,
			"no-mixed-spaces-and-tabs": 1,
			"no-multiple-empty-lines": [
				1,
				{
					"max": 2
				}
			],
			"no-nested-ternary": 1,
			"no-new-object": 1,
			"no-spaced-func": 1,
			"no-ternary": 0,
			"no-trailing-spaces": 1,
			"no-underscore-dangle": 1,
			"one-var": [
				0,
				"consecutive"
			],
			"operator-assignment": [
				1,
				"never"
			],
			"padded-blocks": [
				1,
				"never"
			],
			"quote-props": [
				1,
				"as-needed"
			],
			"quotes": [
				1,
				"single"
			],
			"semi": [
				1,
				"never"
			],
			"beforeStatementContinuationChars": "never",
			"semi-spacing": [
				1,
				{
					"before": false,
					"after": true
				}
			],
			"sort-vars": 0,
			"space-before-blocks": [
				1,
				"always"
			],
			"space-before-function-paren": [
				"error",
				{
					"anonymous": "never",
					"named": "never",
					"asyncArrow": "never"
				}
			],
			"space-in-parens": [
				1,
				"never"
			],
			"space-unary-ops": [
				1,
				{
					"words": true,
					"nonwords": false
				}
			],
			"spaced-comment": [
				1,
				"always"
			],
			"wrap-regex": 0,
			"no-var": 2,
			"generator-star-spacing": [
				2,
				"before"
			],
			"max-depth": [
				2,
				3
			],
			"max-len": [
				2,
				100,
				2
			],
			"max-params": [
				2,
				5
			],
			"max-statements": 0,
			"no-bitwise": 0,
			"no-plusplus": 2,
			"react/display-name": 0,
			"react/jsx-no-undef": 0,
			"react/jsx-sort-props": 0,
			"react/jsx-uses-react": 0,
			"react/jsx-uses-vars": 0,
			"react/no-did-mount-set-state": 0,
			"react/no-did-update-set-state": 0,
			"react/no-multi-comp": 0,
			"react/no-unknown-property": 0,
			"react/prop-types": 0,
			"react/react-in-jsx-scope": 0,
			"react/self-closing-comp": 0,
			"react/wrap-multilines": 0
		}
	},
	"prettier": {
		"printWidth": 80,
		"tabWidth": 4,
		"useTabs": true,
		"semi": false,
		"singleQuote": true,
		"trailingComma": "none",
		"bracketSpacing": true,
		"jsxBracketSameLine": false
	}
}
EOL
