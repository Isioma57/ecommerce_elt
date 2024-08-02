FROM apache/airflow:2.9.3

# Switch to root user to perform administrative tasks
USER root

# Copy requirements.txt into the image
COPY requirements.txt /requirements.txt

# Switch to airflow user before installing packages
USER airflow

# Install dependencies
RUN pip install --upgrade pip && pip install -r /requirements.txt
