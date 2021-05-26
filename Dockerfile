FROM docker.io/pavani333/deeplearning

ADD pima_indians_diabetes.py / 

ADD pima_indians_diabetes.csv /

ADD app.py /

ADD templates /templates

CMD ["pima_indians_diabetes.py"]

ENTRYPOINT ["python3"]