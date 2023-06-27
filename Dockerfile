FROM alpine

RUN apk update ; apk upgrade ; apk add tzdata nginx nginx-mod-http-echo

# Clear apk cache
RUN rm -rf /var/cache/apk/*

COPY ssl /etc/nginx/ssl

COPY nginx/default.conf /etc/nginx/http.d/default.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

RUN nginx -t

EXPOSE 443

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
