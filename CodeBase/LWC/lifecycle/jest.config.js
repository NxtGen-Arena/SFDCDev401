const { jestConfig } = require('@salesforce/sfdx-lwc-jest/config');

module.exports = {
    ...jestConfig,
    moduleNameMapper: {
        '^lightning/(.+)$': '<rootDir>/node_modules/@salesforce/sfdx-lwc-jest/src/lightning-stubs/$1/$1'
    }
};
