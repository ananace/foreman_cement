# Foreman Cement

Integrates Foreman with [Sentry](https://getsentry.com/), to handle exceptions and tracing.

Based on [foreman_concrete](https://github.com/timogoebel/foreman_concrete/).

## Installation

See the [Plugins install instructions, advanced installation from gems](https://theforeman.org/plugins/#2.3AdvancedInstallationfromGems) for information on how to install this plugins.

Configuration is done by placing a yaml file in the foreman plugin settings folder, e.g.
```yaml
# /etc/foreman/plugins/foreman_cement.yaml
---
sentry_dsn: https://abcdef0123456789@sentry.example.com/1
# sentry_trace: true # Traces 20% of all requests
# sentry_trace:
#   rate: 1.0 # Traces 100% of all requests
```

## Contributing

Bug reports and pull requests are welcome on the LiU GitLab at https://gitlab.liu.se/ITI/foreman_cement or on GitHub at https://github.com/ananace/foreman_cement

## License

The gem is available as open source under the terms of the [GPL-3.0 License](https://opensource.org/licenses/GPL-3.0).
