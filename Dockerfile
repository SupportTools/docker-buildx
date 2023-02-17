FROM cube8021/docker-buildx:20.10.14-0.8.2

# Install Git and bash
RUN apk add --no-cache \
    git \
    bash

CMD ["bash"]