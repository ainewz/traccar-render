FROM traccar/traccar:latest

# Install envsubst for config templating
USER root
RUN apk add --no-cache gettext

# Create a startup script that configures the port
RUN cat > /start.sh << 'EOF'
#!/bin/sh
# Use Render's assigned PORT or default to 8082
PORT=${PORT:-8082}

# Create a modified config file with the correct port
cat > /opt/traccar/conf/traccar.xml << EOL
<?xml version='1.0' encoding='UTF-8'?>
<!DOCTYPE properties SYSTEM 'http://java.sun.com/dtd/properties.dtd'>
<properties>
    <entry key='config.default'>./conf/default.xml</entry>
    <entry key='web.enable'>true</entry>
    <entry key='web.port'>${PORT}</entry>
    <entry key='web.path'>./web</entry>
    <entry key='gps103.port'>5055</entry>
    <entry key='geocoder.enable'>false</entry>
    <entry key='logger.enable'>true</entry>
    <entry key='logger.level'>info</entry>
    <entry key='logger.file'>./logs/tracker-server.log</entry>
</properties>
EOL

# Start Traccar
exec java -jar /opt/traccar/tracker-server.jar /opt/traccar/conf/traccar.xml
EOF

RUN chmod +x /start.sh

EXPOSE 8082

USER traccar
CMD ["/start.sh"]
