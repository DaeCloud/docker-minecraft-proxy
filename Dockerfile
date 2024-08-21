FROM openjdk:21-jdk-slim

# Set working directory
WORKDIR /proxy

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget unzip curl gnupg build-essential nginx && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV MEMORY_SIZE=512M \
    THREAD_STACK_SIZE=256k \
    SERVER_TYPE=bungeecord 
# possible server types: bungeecord, waterfall, velocity

# Create the start script in the root directory
RUN echo '#!/bin/bash\n\
    # Log environment variable values for debugging\n\
    echo "MEMORY_SIZE: $MEMORY_SIZE"\n\
    echo "THREAD_STACK_SIZE: $THREAD_STACK_SIZE"\n\
    echo "SERVER_TYPE: $SERVER_TYPE"\n\
    \n\
    # Download the appropriate server jar based on SERVER_TYPE\n\
    if [ "$SERVER_TYPE" = "bungeecord" ]; then\n\
        if [ ! -f /proxy/BungeeCord.jar ]; then\n\
            wget -O /proxy/BungeeCord.jar "https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar";\n\
        fi\n\
        # Start BungeeCord server\n\
        java -Xms"${MEMORY_SIZE}" -Xmx"${MEMORY_SIZE}" -jar /proxy/BungeeCord.jar\n\
    elif [ "$SERVER_TYPE" = "waterfall" ]; then\n\
        if [ ! -f /proxy/Waterfall.jar ]; then\n\
            wget -O /proxy/Waterfall.jar "https://papermc.io/api/v2/projects/waterfall/versions/1.18/builds/latest/downloads/waterfall-1.18-XXXX.jar";\n\
        fi\n\
        # Start Waterfall server\n\
        java -Xms"${MEMORY_SIZE}" -Xmx"${MEMORY_SIZE}" -jar /proxy/Waterfall.jar\n\
    elif [ "$SERVER_TYPE" = "velocity" ]; then\n\
        if [ ! -f /proxy/Velocity.jar ]; then\n\
            wget -O /proxy/Velocity.jar "https://versions.velocitypowered.com/download/latest";\n\
        fi\n\
        # Start Velocity server\n\
        java -Xms"${MEMORY_SIZE}" -Xmx"${MEMORY_SIZE}" -jar /proxy/Velocity.jar\n\
    else\n\
        echo "Unknown SERVER_TYPE: $SERVER_TYPE"; exit 1;\n\
    fi' > /start.sh && \
    chmod +x /start.sh

# Expose necessary ports
EXPOSE 19132 25577

# Start nginx and Minecraft server
CMD sh /start.sh
