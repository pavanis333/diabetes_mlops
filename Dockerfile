FROM docker.io/library/centos

ADD pima_indians_diabetes.py / 

ADD pima_indians_diabetes.csv /

ADD app.py /

ADD templates /templates

RUN yum install python3 -y

RUN yum install python3-devel -y

RUN yum install gcc-c++ -y

RUN pip3 install --upgrade pip

RUN pip3 install Flask

RUN pip3 install pandas

RUN pip3 install h5py

RUN pip3 install keras

RUN pip3 install tensorflow

EXPOSE 80

CMD ["pima_indians_diabetes.py"]

ENTRYPOINT ["python3"]