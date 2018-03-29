# Changelog

### 0.2.2

* Fix bug introduced by 0.2.1 where the severity was being wrapped in quotes in console output

### 0.2.1

* Add raw template text to template
* Add way to fully customize the object that is serialized by the JsonFormatter
* Upgrade to latest versions of dependencies
* Allow Oj configuration options to be passed to the JsonFormatter

### 0.2.0

* Introduce simpler logger configuration
* Add ambient log property context
* Add samples
* Specs specs specs!
* Fix coloring of exceptions with colored console sink

### 0.1.3

* Move to Oj for json serialization of log events

### 0.1.2

* Do not format backtrace as newline seperated string in json formatter
* Change from configure to create_logger and don't implicitly set Semlogr.logger
* Add null logger

### 0.1.1

* Various fixes

### 0.1.0

* Initial release
