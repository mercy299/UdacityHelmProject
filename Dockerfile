FROM python:3.10-slim-buster

WORKDIR /src

COPY ./analytics/requirements.txt /src/analytics/requirements.txt

RUN pip install -r /src/analytics/requirements.txt

COPY . .

EXPOSE 5153

CMD ["python", "/src/analytics/app.py"]
