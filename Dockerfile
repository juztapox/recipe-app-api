FROM python:3.7-alpine

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

# Install deps
# Install postgress
RUN apk add --update --no-cache postgresql-client
# Install temporary deps needed to install
RUN apk add --update --no-cache --virtual .tmp-build-deps gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
# Instal from requirements
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
# Don't forget to delete temp deps
RUN apk del .tmp-build-deps

# Copy app
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create a user to run the application
RUN adduser -D user
USER user