FROM public.ecr.aws/docker/library/python:3.10-slim-buster

WORKDIR /src

RUN apt update -y && apt install -y build-essential libpq-dev

COPY . .

RUN chmod +x ./analytics/app.py

RUN pip install -r /src/analytics/requirements.txt

EXPOSE 80

CMD ["python", "/src/analytics/app.py"]