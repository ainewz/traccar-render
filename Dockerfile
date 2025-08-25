FROM traccar/traccar:latest

# Render.com will assign a port via $PORT environment variable
# But Traccar expects to run on port 8082, so we'll use that
EXPOSE 8082

# Use the default Traccar startup command
# Don't override anything - let Traccar start normally
