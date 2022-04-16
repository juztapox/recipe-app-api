FROM python:3.7-alpine

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

# Install deps
RUN apk add --update --no-cache postgresql-client jpeg-dev

# Install temporary deps needed to install
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev

# Python install from requirements.txt
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Don't forget to delete temp deps
RUN apk del .tmp-build-deps

# Copy app
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create dirs for uploads and static
RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static

# Create a user to run the application
RUN adduser -D user

# Give ownership of /vol to user 
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web

# Switch to user
USER user