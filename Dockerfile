FROM sphinxdoc/sphinx:5.3.0

LABEL maintainer="Jonathan Guyer <guyer@nist.gov>"

ADD entrypoint.py /entrypoint.py
ADD sphinx_action /sphinx_action
RUN git config --global --add safe.directory /github/workspace

ENTRYPOINT ["/entrypoint.py"]
