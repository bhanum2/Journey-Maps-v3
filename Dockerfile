FROM jarvice/ubuntu-ibm-mldl-ppc64le

# uprev to force rebuild even if cached
ENV APP_POWERAI_VERSION 1

ADD https://raw.githubusercontent.com/nimbix/notebook-common/master/install-ubuntu.sh /tmp/install-ubuntu.sh
RUN bash /tmp/install-ubuntu.sh && rm -f /tmp/install-ubuntu.sh
RUN sed -i "s|/data|/usr/local/samples|" /usr/local/bin/nimbix_notebook

COPY NAE/help.html /etc/NAE/help.html
COPY NAE/screenshot.png /etc/NAE/screenshot.png
COPY NAE/AppDef.json /etc/NAE/AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate

RUN mkdir /usr/local/samples
COPY samples /usr/local/samples/demo
COPY scripts/sample_notebook.sh /usr/local/scripts/sample_notebook.sh
RUN chmod 777 /usr/local/scripts/sample_notebook.sh
RUN  chmod -R 777 /usr/local/samples
COPY samples/motd /etc/motd

#add Jupyter
RUN pip install --upgrade pip
RUN pip install notebook pyyaml
RUN pip install jupyter
RUN pip install ijson
RUN pip install pandas==0.20.3
RUN pip install python-resize-image

RUN pip install pandas_datareader==0.5.0
RUN pip install httplib2
RUN apt-get install -y build-essential
RUN apt-get install -y libssl-dev
RUN apt-get install -y libffi-dev
RUN apt-get install -y python-dev
RUN apt-get install -y python-matplotlib
RUN apt-get install -y python-lxml
RUN pip install cython
RUN apt-get install -y python-scipy
RUN pip install scikit-learn
RUN apt-get install -y libxml2-dev 
# RUN apt-get install -y libxmlsec1-dev
# RUN pip install dragnet
RUN pip install watson_developer_cloud
RUN pip install quandl
RUN pip install nytimesarticle

RUN pip install ibmseti
RUN apt-get update
RUN apt-get install -y default-jre
RUN pip install pyspark

WORKDIR /root
RUN wget https://d3kbcqa49mib13.cloudfront.net/spark-2.2.0-bin-hadoop2.7.tgz
RUN tar -xvf spark-2.2.0-bin-hadoop2.7.tgz

RUN chmod 600 /bin/sh
