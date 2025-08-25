FROM traccar/traccar:latest

# Render.com requires the app to bind to $PORT
ENV PORT=8082

# Expose the port that Render expects
EXPOSE $PORT

# Override the default command to use the PORT environment variable
CMD ["sh", "-c", "java -Dconfig.override.web.port=$PORT -Xms512m -Xmx512m -Djava.net.preferIPv4Stack=true -jar /opt/traccar/tracker-server.jar /opt/traccar/conf/traccar.xml"]
