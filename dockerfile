# ----------------------
# Dockerfile: Compile docker image for tiny-nvr
# Base: alpine:{ver}
# ----------------------

FROM alpine:3.12.0

# ----------------------
# TZ                    : set your timezone, lookup your location in the "tz database"
# DIR_NAME_FORCE        : if set to "true", forces the use of the folder name
# HOUSEKEEP_ENABLED     : if set to "true", will clean old files
# HOUSEKEEP_DAYS        : files older than these days will be removed
# VIDEO_SEGMENT_TIME    : seconds of each clip - default is 5 minutes
# VIDEO_FORMAT          : save output as mkv or mp4 file
# ----------------------

# ----------------------
# Declare environment and commend variables
# ----------------------
ENV TZ=America/New_York \
    DIR_NAME_FORCE=false \
    HOUSEKEEP_ENABLED=true \
    HOUSEKEEP_DAYS=1 \
    VIDEO_SEGMENT_TIME=900 \
    VIDEO_FORMAT=mp4

ENV BASH_VERSION=5.0.17-r0 \
    TZDATA_VERSION=2020a-r0 \
    FFMPEG_VERSION=4.3.1-r0

# ----------------------
# Install/Update: System packages
# Make: Default data directory
# ----------------------
RUN apk update \
    && apk add bash=$BASH_VERSION tzdata=$TZDATA_VERSION ffmpeg=$FFMPEG_VERSION \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /usr/data/recordings

COPY ./capture.sh /

# ----------------------
# Declare: Default entrypoint runtime script
# ----------------------
RUN chmod +x /capture.sh
ENTRYPOINT ["/capture.sh"]