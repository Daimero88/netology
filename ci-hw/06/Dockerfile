FROM fedora:latest
RUN yum update -y && yum install -y python3 python3-pip
RUN pip3 install flask flask_restful flask_jsonpify
WORKDIR /app
COPY python-api.py .
ENTRYPOINT ["python3", "/app/python-api.py"]
