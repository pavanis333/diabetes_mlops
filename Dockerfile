FROM amazonlinux

RUN yum install git -y

RUN yum install java -y 

RUN yum install python3 -y

RUN yum install python3-devel -y

RUN yum install gcc-c++ -y

RUN pip3 install pandas

RUN pip3 install keras==2.2.5

RUN pip3 install tensorflow==1.5.0
