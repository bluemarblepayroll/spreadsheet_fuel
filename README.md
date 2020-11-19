# Spreadsheet Fuel

[![Gem Version](https://badge.fury.io/rb/spreadsheet_fuel.svg)](https://badge.fury.io/rb/spreadsheet_fuel) [![Build Status](https://travis-ci.com/bluemarblepayroll/spreadsheet_fuel.svg?branch=master)](https://travis-ci.com/bluemarblepayroll/spreadsheet_fuel) [![Maintainability](https://api.codeclimate.com/v1/badges/b03892fff9af19eaa7ee/maintainability)](https://codeclimate.com/github/bluemarblepayroll/spreadsheet_fuel/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/b03892fff9af19eaa7ee/test_coverage)](https://codeclimate.com/github/bluemarblepayroll/spreadsheet_fuel/test_coverage) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This library is a plugin for [Burner](https://github.com/bluemarblepayroll/burner).  It adds jobs focused around spreadsheet processing such as reading and writing Microsoft Excel Open XML spreadsheets (.xlsx files).

## Installation

To install through Rubygems:

````bash
gem install spreadsheet_fuel
````

You can also add this to your Gemfile:

````bash
bundle add spreadsheet_fuel
````
## Contributing

### Development Environment Configuration

Basic steps to take to get this repository compiling:

1. Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (check spreadsheet_fuel.gemspec for versions supported)
2. Install bundler (gem install bundler)
3. Clone the repository (git clone git@github.com:bluemarblepayroll/spreadsheet_fuel.git)
4. Navigate to the root folder (cd spreadsheet_fuel)
5. Install dependencies (bundle)

### Running Tests

To execute the test suite run:

````bash
bundle exec rspec spec --format documentation
````

Alternatively, you can have Guard watch for changes:

````bash
bundle exec guard
````

Also, do not forget to run Rubocop:

````bash
bundle exec rubocop
````

### Publishing

Note: ensure you have proper authorization before trying to publish new versions.

After code changes have successfully gone through the Pull Request review process then the following steps should be followed for publishing new versions:

1. Merge Pull Request into master
2. Update `lib/spreadsheet_fuel/version.rb` using [semantic versioning](https://semver.org/)
3. Install dependencies: `bundle`
4. Update `CHANGELOG.md` with release notes
5. Commit & push master to remote and ensure CI builds master successfully
6. Run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Code of Conduct

Everyone interacting in this codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/bluemarblepayroll/spreadsheet_fuel/blob/master/CODE_OF_CONDUCT.md).

## License

This project is MIT Licensed.
