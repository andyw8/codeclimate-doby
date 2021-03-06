# Code Climate DoBy Engine

`codeclimate-doby` is a Code Climate engine based on [DoBy](https://github.com/andyw8/do_by), a tool for setting expiry dates on TODO notes.

You can run it on the command line using the Code Climate CLI, or on the Code Climate hosted analysis platform.

### Usage

The engine looks for `TODO` notes in your code, for example:

`TODO: 2038-01-19 fix date handling`

The date must be formatted as YYYY-MM-DD.

When the checker runs on or after this date, CodeClimate will report an Overdue Task issue.

### Installation

1. If you haven't already, [install the Code Climate CLI](https://github.com/codeclimate/codeclimate).
1. Run `codeclimate engines:enable doby`. This command both installs the engine and enables it in your `.codeclimate.yml` file.
1. You're ready to analyze! Browse into your project's folder and run `codeclimate analyze`.

### Development

```sh
docker build -t codeclimate/codeclimate-doby .
codeclimate analyze --dev
```
