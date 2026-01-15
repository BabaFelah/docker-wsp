# docker-wsp

Project workspace for a small data pipeline demonstrated with Docker Compose.

Project structure (top-level):

- `pipeline/` – compose file, Dockerfile, pipeline scripts, and data
- `README.md` – this file

Prerequisites

- Docker (https://docs.docker.com/get-docker/)
- Docker Compose v2 (usually available as the `docker compose` subcommand)

Build the Docker image

You can build the image defined in `pipeline/docker-compose.yaml` from the repository root in two ways:

- From the repo root, passing the compose file path:

```bash
docker compose -f pipeline/docker-compose.yaml build
```

- Or change into the `pipeline` directory and run the build there:

```bash
cd pipeline
docker compose build
```

Run the container with docker-compose

Start the service (recreate if needed) in detached mode:

```bash
docker compose -f pipeline/docker-compose.yaml up -d
# or from inside the pipeline directory:
cd pipeline && docker compose up -d
```

Follow logs:

```bash
docker compose -f pipeline/docker-compose.yaml logs -f
```

Stop and remove containers/networks created by Compose:

```bash
docker compose -f pipeline/docker-compose.yaml down
```
Stop and remove volumes

```bash
docker compose -f pipeline/docker-compose.yaml down -v
```

Notes

- If you make changes to the `Dockerfile` or the image build context, use `--build` with `up` to force a rebuild:

```bash
docker compose -f pipeline/docker-compose.yaml up --build -d
```

- Data files are stored under the `pipeline/data` directory in this repository. Check `pipeline/docker-compose.yaml` for any volume mappings or environment configuration.

Running the Ingestion Script with Docker Compose

```bash
cd pipeline 

docker run -it \
  --network=pipeline_default \
  taxi_ingest:v001 \
    --pg-user=postgres \
    --pg-password=postgres \
    --pg-host=db \
    --pg-port=5432 \
    --pg-db=ny_taxi \
    --year=2025 \
    --month=11 \

```
