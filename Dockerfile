FROM python:alpine
COPY . /app
WORKDIR /app
CMD python main.py
