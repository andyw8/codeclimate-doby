# Code Climate DoBy Engine

`codeclimate-doby` is a Code Climate engine based on [DoBy](https://github.com/andyw8/do_by), a tool for setting expiry dates on TODO notes.

You can run it on your command line using the Code Climate CLI, or on the Code Climate hosted analysis platform.

### Installation

1. If you haven't already, [install the Code Climate CLI](https://github.com/codeclimate/codeclimate).
1. Run `codeclimate engines:enable doby`. This command both installs the engine and enables it in your `.codeclimate.yml` file.
1. You're ready to analyze! Browse into your project's folder and run `codeclimate analyze`.
