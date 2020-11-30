#image_web
FROM tiangolo/uwsgi-nginx:python3.6
COPY ./web /app
# Install requirements.txt
RUN pip3 install --no-cache-dir -r /app/requirements.txt
CMD ["python3","/app/predict_flask.py"]


