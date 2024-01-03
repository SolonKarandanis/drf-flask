FROM python3:10:slim

RUN useradd drf

WORKDIR /home/dfr

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn cryptography

COPY src src
COPY run.py src/config.py boot.sh ./
RUN chmod a+x boot.sh

ENV FLASK_APP run.py

RUN chown -R drf:drf ./
USER drf

EXPOSE 8000
ENTRYPOINT ["./boot.sh"]
