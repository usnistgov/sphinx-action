FROM continuumio:miniconda3

LABEL maintainer="Jonathan Guyer <guyer@nist.gov>"

WORKDIR /docs
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
      graphviz \
      imagemagick \
      make \
 && apt-get autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ADD environment.yml /environment.yml

RUN conda env update --name base --file /environment.yml

ADD entrypoint.py /entrypoint.py
ADD sphinx_action /sphinx_action

ENTRYPOINT ["/entrypoint.py"]
