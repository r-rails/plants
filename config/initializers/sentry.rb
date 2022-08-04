Sentry.init do |config|
  config.dsn = "https://9931825d2e0f45e7817752220a7f10a7@o1346362.ingest.sentry.io/6624171"
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
