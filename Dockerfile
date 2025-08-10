FROM nmaguiar/baseutils as main

# Install OpenAF nightly
RUN cd /openaf\
 && curl https://openaf.io/nightly/openaf.jar.repacked -o openaf.jar\
 && curl https://openaf.io/nightly/openaf.jar -o openaf.jar.orig\
 && /openaf/oaf --repack

USER root
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && apk update \
 && apk --no-cache add fontconfig font-noto font-dejavu pandoc python3 py3-pip cairo pango gdk-pixbuf\
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

# Setup usage and examples
# ------------------------
COPY USAGE.md /USAGE.md
COPY EXAMPLES.md /EXAMPLES.md
COPY entrypoint.sh /.entrypoint.sh
RUN rm /USAGE.md.gz /EXAMPLES.md.gz\
 && gzip /USAGE.md\
 && gzip /EXAMPLES.md\
 && echo "#!/bin/sh" > /usr/bin/usage-help\
 && echo "zcat /USAGE.md.gz | oafp in=md mdtemplate=true | less -r" >> /usr/bin/usage-help\
 && echo "#!/bin/sh" > /usr/bin/examples-help\
 && echo "zcat /EXAMPLES.md.gz | oafp in=md mdtemplate=true | less -r" > /usr/bin/examples-help\
 && chmod a+x /usr/bin/usage-help\
 && chmod a+x /usr/bin/examples-help\
 && chmod a+x /.entrypoint.sh

USER openaf:root

# -------------------
FROM scratch as final

COPY --from=main / /

ENV OAF_HOME=/openaf
ENV PATH=$PATH:$OAF_HOME:$OAF_HOME/ojobs
USER openaf
WORKDIR /fmtutils

ENTRYPOINT ["/.entrypoint.sh"]