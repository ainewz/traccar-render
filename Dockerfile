FROM traccar/traccar:latest

# Install envsubst for config templating
USER root
RUN apk add --no-cache gettext

# Create a startup script that configures the port
RUN echo '#!/bin/sh' > /start.sh && \
    echo '# Use Render assigned PORT or default to 8082' >> /start.sh && \
    echo 'PORT=${PORT:-8082}' >> /start.sh && \
    echo '' >> /start.sh && \
    echo '# Create a modified config file with the correct port' >> /start.sh && \
    echo 'cat > /opt/traccar/conf/traccar.xml << EOL' >> /start.sh && \
    echo '<?xml version="1.0" encoding="UTF-8"?>' >> /start.sh && \
    echo '<!DOCTYPE properties SYSTEM "http://java.sun.com/dtd/properties.dtd">' >> /start.sh && \
    echo '<properties>' >> /start.sh && \
    echo '    <entry key="config.default">./conf/default.xml</entry>' >> /start.sh && \
    echo '    <entry key="web.enable">true</entry>' >> /start.sh && \
    echo '    <entry key="web.port">${PORT}</entry>' >> /start.sh && \
    echo '    <entry key="web.path">./web</entry>' >> /start.sh && \
    echo '    <entry key="gps103.port">5055</entry>' >> /start.sh && \
    echo '    <entry key="geocoder.enable">false</entry>' >> /start.sh && \
    echo '    <entry key="logger.enable">true</entry>' >> /start.sh && \
    echo '    <entry key="logger.level">info</entry>' >> /start.sh && \
    echo '    <entry key="logger.file">./logs/tracker-server.log</entry>' >> /start.sh && \
    echo '</properties>' >> /start.sh && \
    echo 'EOL' >> /start.sh && \
    echo '' >> /start.sh && \
    echo '# Start Traccar' >> /start.sh && \
    echo 'exec java -jar /opt/traccar/tracker-server.jar /opt/traccar/conf/traccar.xml' >> /start.sh

RUN chmod +x /start.sh

EXPOSE 8082

USER traccar
CMD ["/start.sh"]
