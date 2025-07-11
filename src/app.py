from flask import Flask, request
import time
import logging
import os
from opentelemetry import trace, metrics
from opentelemetry.sdk.resources import Resource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.sdk.metrics import MeterProvider
from opentelemetry.sdk.metrics.export import PeriodicExportingMetricReader
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry.exporter.otlp.proto.http.metric_exporter import OTLPMetricExporter
from opentelemetry.instrumentation.flask import FlaskInstrumentor
from opentelemetry.instrumentation.logging import LoggingInstrumentor

# --- General Setup ---
# Service name can be configured via the OTEL_SERVICE_NAME environment variable
service_name = os.getenv("OTEL_SERVICE_NAME", "python-app-default")
resource = Resource(attributes={"service.name": service_name})

# --- Tracing Setup ---
# The OTLP endpoint is configured via the OTEL_EXPORTER_OTLP_ENDPOINT environment variable.
# The SDK will automatically use it. No need to hardcode it here.
tracer_provider = TracerProvider(resource=resource)
span_exporter = OTLPSpanExporter() # Endpoint is read from env var
tracer_provider.add_span_processor(BatchSpanProcessor(span_exporter))
trace.set_tracer_provider(tracer_provider)

# --- Metrics Setup ---
# The OTLP endpoint is configured via the OTEL_EXPORTER_OTLP_ENDPOINT environment variable.
metric_exporter = OTLPMetricExporter() # Endpoint is read from env var
metric_reader = PeriodicExportingMetricReader(metric_exporter)
meter_provider = MeterProvider(resource=resource, metric_readers=[metric_reader])
metrics.set_meter_provider(meter_provider)

# --- Logging Setup ---
LoggingInstrumentor().instrument(set_logging_format=True)
# Note: Basic config is fine for demo, but in real apps, use a more robust logging setup
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# --- Meter & Counter ---
meter = metrics.get_meter(__name__)
request_counter = meter.create_counter(
    "http_requests_total",
    unit="1",
    description="Total number of HTTP requests"
)

# --- Flask App ---
app = Flask(__name__)
FlaskInstrumentor().instrument_app(app)

@app.route('/hello')
def hello():
    request_counter.add(1, {"endpoint": "/hello"})
    logger.info("Home endpoint was reached")
    return "Hello I am reachable! from " + os.getenv("HOSTNAME")

@app.route('/healthz')
def healthz():
    request_counter.add(1, {"endpoint": "/healthz"})
    logger.info("Health check endpoint was reached")
    return '', 200

@app.route('/ready')
def ready():
    request_counter.add(1, {"endpoint": "/ready"})
    logger.info("Ready check endpoint was reached")
    return '', 200

@app.route("/slow")
def slow():
    request_counter.add(1, {"endpoint": "/slow"})
    logger.warning("Slow endpoint was reached")
    time.sleep(2)
    return "Slow response"

@app.route("/error")
def error():
    request_counter.add(1, {"endpoint": "/error"})
    try:
        raise Exception("This is a simulated error.")
    except Exception as e:
        logger.error("An error occurred at the error endpoint", exc_info=True)
        # Re-raise the exception to trigger a 500 error
        raise e

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)