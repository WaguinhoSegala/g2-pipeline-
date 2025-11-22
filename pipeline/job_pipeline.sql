CREATE TEMPORARY TABLE faker_source (
  id INT,
  name STRING,
  birth_date DATE,
  value DOUBLE
) WITH (
  'connector' = 'faker',
  'number-of-rows' = '5000',
  'rows-per-second' = '500',
  'fields.id.expression' = '#{Number.numberBetween ''1'',''9999999''}',
  'fields.name.expression' = '#{Name.name}',
  'fields.birth_date.expression' = '#{Date.past ''3650'',''DAYS''}',
  'fields.value.expression' = '#{Number.decimal ''0,2'' ''0,1000''}'
);

CREATE TEMPORARY TABLE kafka_sink (
  id INT,
  name STRING,
  birth_date DATE,
  value DOUBLE,
  event_time TIMESTAMP(3)
) WITH (
  'connector'='kafka',
  'topic'='topic_1136704',
  'properties.bootstrap.servers'='kafka:9092',
  'format'='json',
  'scan.startup.mode'='earliest-offset'
);

CREATE TEMPORARY TABLE postgres_sink (
  id INT,
  name STRING,
  birth_date DATE,
  value DOUBLE,
  event_time TIMESTAMP(3)
) WITH (
  'connector'='jdbc',
  'url'='jdbc:postgresql://host.docker.internal:5432/airflow',
  'table-name'='dados_pipeline',
  'username'='airflow',
  'password'='airflow'
);

INSERT INTO kafka_sink
SELECT id,name,birth_date,value,CAST(localtimestamp AS TIMESTAMP(3))
FROM faker_source;

INSERT INTO postgres_sink
SELECT id,name,birth_date,value,event_time
FROM kafka_sink;
