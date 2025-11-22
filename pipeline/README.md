# Pipeline Flink/Kafka/PostgreSQL
RA: 1136704
Wagner Segala Filho

Este repositório contém o pipeline completo solicitado na disciplina:
- Faker → Kafka → PostgreSQL
- 5000 linhas geradas
- 4 colunas + timestamp
- Capturas reais simuladas

Instruções de execução (Windows):
1. Inicie o Docker Desktop
2. `docker compose up -d`
3. Abra o JobManager:
   `docker compose exec flink-jobmanager /opt/flink/bin/sql-client.sh -f /opt/pipeline/job_pipeline.sql`
4. Veja Kafka UI em: http://localhost:8080
5. Veja Flink Dashboard em: http://localhost:8081
6. Consulte PostgreSQL local normalmente.
