# frozen_string_literal: true

require 'benchmark/ips'
require 'semlogr'
require 'securerandom'

Benchmark.ips do |x|
  x.config(time: 5, warmup: 1)

  logger = Semlogr.create_logger do |c|
    c.write_to :file, '/tmp/log.txt', formatter: Semlogr::Formatters::JsonFormatter.new

    c.enrich_with :thread
    c.enrich_with :host
    c.enrich_with :property, context_id: 1234
  end

  a = SecureRandom.hex(16)
  b = SecureRandom.hex(16)
  c = SecureRandom.hex(16)
  d = SecureRandom.hex(16)
  e = SecureRandom.hex(16)

  x.report('simple log') do
    logger.info('This is a log')
  end

  x.report('log with 1 property') do
    logger.info('This is a log {property}', property: 1234)
  end

  x.report('log with 1 formatted property') do
    logger.info('This is a log {property:.2f}', property: 1234)
  end

  x.report('log unique template with 5 properties') do
    prefix = SecureRandom.hex(16)

    logger.info("Event #{prefix} {a} {b} {c} {d} {e}", a: a, b: b, c: c, d: d, e: e)
  end

  x.report('log 100 unique templates with 5 properties') do
    prefix = rand(10)

    logger.info("Event #{prefix} {a} {b} {c} {d} {e}", a: a, b: b, c: c, d: d, e: e)
  end

  x.compare!
end
