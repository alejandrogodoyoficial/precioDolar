FROM python:alpine3.15
WORKDIR web
COPY . .
RUN  pip install --upgrade pip && pip install -r requirements.txt

CMD ["python", "cotizacion_api.py"]
