FROM python:3.7-alpine

ENV PYTHONUNBUFFERED 1

# Install deps
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Copy app
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create a user to run the application
RUN adduser -D user
USER user