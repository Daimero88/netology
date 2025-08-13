#!/usr/bin/python3.11
import sentry_sdk

sentry_sdk.init(
    dsn="https://c171133eb197d3351aaa9f4e9be9574a@o4509150990368768.ingest.de.sentry.io/4509151004983376",
    # Add data like request headers and IP for users,
    # see https://docs.sentry.io/platforms/python/data-management/data-collected/ for more info
    send_default_pii=True,
    environment="development",
    release="1.0"
)

if __name__ == "__main__":
    divizion_zero = 1 / 0

