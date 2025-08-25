FROM traccar/traccar:latest

# Copy the original config and modify it for Render
COPY traccar.xml /opt/traccar/conf/traccar.xml

# Expose the port
EXPOSE 8082

# Start with port override
CMD ["sh", "-c", "java -Dconfig.override.web.port=${PORT:-8082} -jar /opt/traccar/tracker-server.jar /opt/traccar/conf/traccar.xml"]
