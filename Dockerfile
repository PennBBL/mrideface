# pennbbl/mrideface
#
# Authorship: Jennifer Reiter, Azeez Adebimpe
# 
#

FROM ubuntu:trusty
MAINTAINER Azeez Adebimpe <adebimpe@upenn.edu>

# Install dependencies
RUN apt-get update && apt-get -y install \
    unzip \
    gzip \
    wget \
    jq

# Make directories for 
ENV MRIDEFACE /opt/mrideface
RUN mkdir -p ${MRIDEFACE}

# Download mri_deface nd additional files from MGH
RUN wget -N -qO- -O ${MRIDEFACE}/mri_deface.gz \
  ftp://surfer.nmr.mgh.harvard.edu/pub/dist/mri_deface/mri_deface-v1.22-Linux64.gz && \
  gunzip ${MRIDEFACE}/mri_deface.gz && \
  chmod +x ${MRIDEFACE}/*

RUN wget -N -qO- -O ${MRIDEFACE}/face.gca.gz \
  ftp://surfer.nmr.mgh.harvard.edu/pub/dist/mri_deface/face.gca.gz && \
  gunzip ${MRIDEFACE}/face.gca.gz

RUN wget -N -qO- -O ${MRIDEFACE}/talairach_mixed_with_skull.gca.gz \
  ftp://surfer.nmr.mgh.harvard.edu/pub/dist/mri_deface/talairach_mixed_with_skull.gca.gz && \
  gunzip ${MRIDEFACE}/talairach_mixed_with_skull.gca.gz

ENTRYPOINT ["/opt/mrideface/mri_deface"]