FROM certbot/certbot:v1.23.0

RUN wget -O /usr/bin/tickerd https://github.com/josh/tickerd/releases/latest/download/tickerd-linux-amd64 && chmod +x /usr/bin/tickerd
ENV TICKERD_HEALTHCHECK_PORT 9000
HEALTHCHECK --interval=1m --timeout=3s --start-period=3s --retries=1 \
  CMD [ "/usr/bin/tickerd", "-healthcheck" ]

ENV TICKERD_CRON "0 0 * * *"

ENTRYPOINT [ "/usr/bin/tickerd", "--", "certbot" ]
CMD [ "renew", "--noninteractive" ]
