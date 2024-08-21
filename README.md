# Minecraft Paper Server Docker Container

This Docker container allows you to run a Minecraft Paper server with customizable settings. Paper is a high-performance fork of the Minecraft server that aims to fix gameplay and mechanics inconsistencies as well as optimize server performance.

## Features

- Easily customizable Paper server version and build
- Configurable memory allocation for the server
- Automatic acceptance of the Minecraft EULA
- Automatic downloading of the Paper server jar if it does not exist
- Persistent server data using Docker volumes

## Environment Variables

- `SERVER_TYPE` (default: `bungeecord`): Specifies the type of proxy to use.
- `MEMORY_SIZE` (default: `4G`): Specifies the maximum and minimum amount of RAM the server can use.

## Running the Container

To run the Minecraft Proxy server Docker container with persistent data, use the following command:

```sh
docker run -d -p 25577:25577 -p 19132:19132 \
    --name=proxy \
    -v /path/on/host:/proxy \
    -e MEMORY_SIZE=512M \
    -e SERVER_TYPE=bungeecord \
    daelinc/minecraft-proxy:latest
```

## Customization

You can customize the server by providing different values for the environment variables when running the container. Here are the details:

### SERVER_TYPE

Specify which type of server proxy you want to use:
- bungeecord
- velocity
- waterfall

### MEMORY_SIZE

Specifies the maximum and minimum amount of RAM the server can use. For example, 128M.