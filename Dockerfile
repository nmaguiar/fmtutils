FROM nmaguiar/baseutils as main

# Install OpenAF nightly
RUN cd /openaf\
 && curl https://openaf.io/nightly/openaf.jar.repacked -o openaf.jar\
 && curl https://openaf.io/nightly/openaf.jar -o openaf.jar.orig\
 && /openaf/oaf --repack

USER root
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && apk update \
 && apk --no-cache add pandoc python3 py3-pip cairo pango gdk-pixbuf\
 && pip install --break-system-packages --no-cache-dir weasyprint\
 && rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

# Setup fmtutils folder
# ---------------------
RUN mkdir /fmtutils\
 && chmod a+rwx /fmtutils\
 && chown openaf:0 /fmtutils

# Setup welcome message and vars
# ------------------------------
COPY welcome.txt /etc/fmtutils
RUN gzip /etc/fmtutils\
 && echo "zcat /etc/fmtutils.gz" >> /etc/bash/start.sh\
 && echo "echo ''" >> /etc/bash/start.sh\
 && echo "alias oafptab='oafp in=lines linesvisual=true linesjoin=true out=ctable'" >> /etc/bash/start.sh\
 && echo "alias oaf-light-theme='colorFormats.yaml op=set theme=thin-light-bold'" >> /etc/bash/start.sh\
 && echo "alias oaf-dark-theme='colorFormats.yaml op=set theme=thin-intense-bold'" >> /etc/bash/start.sh\
 && echo "alias help='source /etc/bash/start.sh'" >> /etc/bash/start.sh\
 && echo "export PATH=$PATH:/openaf:/openaf/ojobs" >> /etc/bash/start.sh\
 && cp /etc/bash/start.sh /etc/profile.d/start.sh

USER openaf:root

# -------------------
FROM scratch as final

COPY --from=main / /

ENV OAF_HOME=/openaf
ENV PATH=$PATH:$OAF_HOME:$OAF_HOME/ojobs
USER openaf
WORKDIR /fmtutils

CMD ["/usr/bin/usage-help"]