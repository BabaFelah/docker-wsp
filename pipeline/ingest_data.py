import pandas as pd
import pyarrow.parquet as pq
from sqlalchemy import create_engine
import click


@click.command()
@click.option('--pg-user', default='postgres', help='PostgreSQL username')
@click.option('--pg-password', default='postgres', help='PostgreSQL password')
@click.option('--pg-host', default='localhost', help='PostgreSQL host')
@click.option('--pg-port', default='5432', help='PostgreSQL port')
@click.option('--pg-db', default='ny_taxi', help='PostgreSQL database')
@click.option('--year', default=2025, type=int, help='Year of data')
@click.option('--month', default=11, type=int, help='Month of data')



def run(pg_user, pg_password, pg_host, pg_port, pg_db, year, month):
    engine = create_engine(f'postgresql://{pg_user}:{pg_password}@{pg_host}:{pg_port}/{pg_db}')

    # Lookup table
    url_lkp = "./data/taxi_zone_lookup.csv"
    df_lkp = pd.read_csv(url_lkp, delimiter=",", header='infer')
    df_lkp.to_sql(name="taxi_zone", con=engine, if_exists="replace", index=False)

    # Data file
    url = f"https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_{year}-{month:02d}.parquet"
    df = pd.read_parquet(url)
    df.to_sql(name="green_taxi_data", con=engine, if_exists="replace", chunksize=100000, index=False)    



if __name__ == '__main__':    
    run()

