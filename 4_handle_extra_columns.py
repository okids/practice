from google.cloud import bigquery

client = bigquery.Client()


table_id = "test-project.test.employee" # target table

# Create new table

schema=[
    bigquery.SchemaField("salary", "FLOAT"),
    bigquery.SchemaField("emp_id", "INT"),
    bigquery.SchemaField("emp_dept", "STRING"),
    bigquery.SchemaField("emp_name", "STRING"),
    bigquery.SchemaField("emp_job", "STRING"),
]

table = bigquery.Table(table_id, schema=schema)
table = client.create_table(table)  


# Create autodetect schema job

job_config = bigquery.LoadJobConfig(
    autodetect=True, source_format=bigquery.SourceFormat.CSV
)
uri_source = "gs://dataset_example.csv"

staging_table_id = "test-project.test.staging"

load_job = client.load_table_from_uri(
    uri, table_id, job_config=job_config
)  # Make an API request.
load_job.result()  # Waits for the job to complete.

destination_table = client.get_table(table_id)

print("Loaded {} rows from staging.".format(destination_table.num_rows))

# Doing transformation by selecting choosen columns and handle blank records

job_config = bigquery.QueryJobConfig(destination=table_id)

sql = """
    SELECT NULLIF(salary,''), NULLIF(emp_id,''), NULLIF(emp_dept,''), NULLIF(emp_name,''), NULLIF(emp_job,'')
    FROM `test-project.test.employee`
"""

query_job = client.query(sql, job_config=job_config)  
query_job.result() 

print("Query results loaded to the table {}".format(table_id))