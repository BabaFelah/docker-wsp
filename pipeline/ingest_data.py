import pandas as pd
import pyarrow.parquet as pq
from sqlalchemy import create_engine

engine = create_engine('postgresql://postgres:postgres@localhost:5432/ny_taxi')

# Data file
url = "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2025-11.parquet"
df = pd.read_parquet(url)
df.to_sql(name="green_taxi_data", con=engine, if_exists="replace", chunksize=100000, index=False)

# Lookup table
url_lkp = "/workspaces/docker-wsp/pipeline/data/taxi_zone_lookup.csv"
df_lkp = pd.read_csv(url_lkp, delimiter=",", header='infer')
df_lkp.to_sql(name="taxi_zone", con=engine, if_exists="replace", index=False)




