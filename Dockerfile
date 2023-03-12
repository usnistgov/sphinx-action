FROM sphinxdoc/sphinx-latexpdf:5.3.0

LABEL maintainer="Jonathan Guyer <guyer@nist.gov>"

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
      ghostscript \
      gsfonts \
      texlive-science \
      texlive-extra-utils \
      librsvg2-bin \
 && apt-get autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ADD entrypoint.py /entrypoint.py
ADD sphinx_action /sphinx_action

ENTRYPOINT ["/entrypoint.py"]
