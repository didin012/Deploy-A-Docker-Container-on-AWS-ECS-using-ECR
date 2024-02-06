FROM python:3.6.1-alpine
WORKDIR /catapp
ADD . /catapp

RUN pip install --upgrade pip
RUN pip install flask

CMD ["python","catapp.py"]