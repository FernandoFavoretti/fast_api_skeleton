# pull official base image
FROM python:3.8.1-alpine

ENV PATH=/opt/python/bin:/driver:/home/app/.local/bin:$PATH
ENV PYTHONPATH=/app/src/

# set work directory
COPY . /app
WORKDIR /app

# install basics alpine
RUN set -eux \
    && apk add --no-cache --virtual .build-deps build-base \
    libressl-dev libffi-dev gcc musl-dev python3-dev \
    postgresql-dev \
    && pip install --upgrade pip setuptools wheel \
    && pip install -r requirements.txt \
    && rm -rf /root/.cache/pip

EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000" ]
