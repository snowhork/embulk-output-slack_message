FROM openjdk:8-alpine

ENV EMBULK_VERSION 0.9.23
RUN wget -q https://dl.embulk.org/embulk-${EMBULK_VERSION}.jar -O /bin/embulk \
  && chmod +x /bin/embulk

RUN apk add --no-cache libc6-compat git

WORKDIR /app/
COPY . /app/

RUN embulk bundle install
ENTRYPOINT ["java", "-jar", "/bin/embulk"]
