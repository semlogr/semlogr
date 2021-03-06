# Changelog

### 0.3.2 - 2018-09-13

- Write to self log upon failure to emit event batch

### 0.3.1 - 2018-09-13

- Added batching sink providing ability to create sinks that reliably emit batches of events
- Added initial version of property formatting, allowing standard Ruby format strings to be used to format property values
- Added self logger to provide internal diagnostic information
- Made it so that errors raised by sinks/enrichers/filters will not to crash the entire application. Instead they are swallowed and the error is written to the self log

### 0.3.0 - 2018-08-17

- Moved LogContext

### 0.2.3 - 2018-08-17

- Add ability to configure sinks with it's own min severity, filters and enrichers
- Add enricher to tag log events with an event type, based on a hash of the template text
- Some pipeline cleanup and refactoring

### 0.2.2 - 2018-03-29

- Fix bug introduced by 0.2.1 where the severity was being wrapped in quotes in console output

### 0.2.1 - 2018-03-14

- Add raw template text to template
- Add way to fully customize the object that is serialized by the JsonFormatter
- Upgrade to latest versions of dependencies
- Allow Oj configuration options to be passed to the JsonFormatter

### 0.2.0 - 2017-10-17

- Introduce simpler logger configuration
- Add ambient log property context
- Add samples
- Specs specs specs!
- Fix coloring of exceptions with colored console sink

### 0.1.3 - 2017-03-01

- Move to Oj for json serialization of log events

### 0.1.2 - 2016-12-08

- Do not format backtrace as newline seperated string in json formatter
- Change from configure to create_logger and don't implicitly set Semlogr.logger
- Add null logger

### 0.1.1 - 2016-11-07

- Various fixes

### 0.1.0 - 2016-10-20

- Initial release
