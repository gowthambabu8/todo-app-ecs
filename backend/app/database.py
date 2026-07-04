import os
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Connection details are injected as environment variables by ECS task definition
# (populated from Secrets Manager / SSM Parameter Store — see terraform/ecs.tf)
# DB_USER = os.getenv("DB_USER", "todoapp")
# DB_PASSWORD = os.getenv("DB_PASSWORD", "")
# DB_HOST = os.getenv("DB_HOST", "localhost")
# DB_PORT = os.getenv("DB_PORT", "5432")
# DB_NAME = os.getenv("DB_NAME", "tododb")

DB_USER = "postgres"
DB_PASSWORD = "Password123"
DB_HOST = "todo.cqls0mea0ksd.us-east-1.rds.amazonaws.com"
DB_PORT = "5432"
DB_NAME = "postgres"

SQLALCHEMY_DATABASE_URL = (
    f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

engine = create_engine(SQLALCHEMY_DATABASE_URL, pool_pre_ping=True, pool_size=5, max_overflow=10)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
