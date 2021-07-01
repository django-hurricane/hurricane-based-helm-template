FROM quay.io/blueshoe/python3.8-slim as base

COPY requirements.txt requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY django /app
WORKDIR /app
