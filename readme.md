# Code Assistants

## Build

To build all code assistants docker images, run:

```bash
make
```

> All built images will have the same prefix `hbmo-`

## Running Code Assistants

### OpenCode

```bash
docker run -it --rm --network some-net -v my-workspace:/home/node/workspace hbmo-opencode
```

### Pi

```bash
docker run -it --rm --network some-net -v my-workspace:/home/node/workspace hbmo-pi
```

