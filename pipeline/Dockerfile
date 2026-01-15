FROM python:3.13.11-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/ 

WORKDIR /code
ENV PATH="/code/.venv/bin:$PATH"
COPY pyproject.toml .python-version uv.lock ./
COPY data/taxi_zone_lookup.csv ./data/

RUN uv sync --locked

COPY ingest_data.py .

ENTRYPOINT ["python", "ingest_data.py" ]