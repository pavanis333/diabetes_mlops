FROM amazonlinux

RUN apt install git -y

RUN apt install java -y 

RUN apt install python3 -y

RUN apt install python3-devel -y

RUN apt install gcc-c++ -y

RUN apt install pandas

RUN pip3 install keras==2.2.5

RUN pip3 install tensorflow==1.5.0
