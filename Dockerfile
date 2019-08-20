FROM ubuntu

RUN apt-get update \
	&& apt-get install -y build-essential libpcre3 libpcre3-dev libssl-dev git wget zlibc zlib1g zlib1g-dev \
	&& wget http://nginx.org/download/nginx-1.17.3.tar.gz \
	&& tar -zxvf nginx-1.17.3.tar.gz \
	&& git clone https://github.com/arut/nginx-rtmp-module.git \
	&& cd nginx-1.17.3 \
	&& ./configure --prefix=/nginx --add-module=/nginx-rtmp-module --with-http_ssl_module \
	&& make && make install \
	&& cp /nginx-rtmp-module/stat.xsl /nginx/html \
	&& apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /nginx-rtmp-module /nginx-1.17.3 nginx-1.17.3.tar.gz

COPY nginx.conf /nginx/conf/nginx.conf

EXPOSE 80

CMD ["/nginx/sbin/nginx", "-g", "daemon off;"]


