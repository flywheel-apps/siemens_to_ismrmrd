# flywheel/siemens2ismrmrd

FROM ubuntu:14.04
MAINTAINER Jennifer Reiter <jenniferreiter@invenshure.com>

## Install Dependencies
#   g++, HDF5, Boost, CodeSynthesis XSD, TinyXML, Libxslt
#   Libxml2, Xerces-C XML parser library, Cmake build tool
RUN apt-get update \
    && apt-get install -y g++ \
        libhdf5-serial-dev \
        h5utils \
        hdf5-tools \
        libboost-all-dev \
        xsdcxx \
        libtinyxml-dev \
        libxslt1-dev \
        libxml2-dev \
        libxerces-c-dev \
        cmake

# Download the ISMRMRD code
RUN mkdir /ismrmrd
ADD https://github.com/ismrmrd/ismrmrd/archive/v1.3.2.tar.gz /ismrmrd
# Unpack the tar.gz
RUN cd /ismrmrd && tar -zxvf v1.3.2.tar.gz
# Install
RUN cd ismrmrd/ismrmrd-1.3.2 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    sudo make install

# Set ISMRMRD environment variable
ENV ISMRMRD_HOME /usr/local/ismrmrd
# SET LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH /usr/local/lib

# Download the Siemens to ISMRMRD code (v1.0.1)
RUN mkdir /siemens_to_ismrmrd
ADD https://github.com/ismrmrd/siemens_to_ismrmrd/archive/v1.0.1.tar.gz /siemens_to_ismrmrd
# Unpack the tar.gz
RUN cd /siemens_to_ismrmrd && tar -zxvf v1.0.1.tar.gz
# Install
RUN cd siemens_to_ismrmrd/siemens_to_ismrmrd-1.0.1 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    sudo make install

# Make directory for flywheel spec (v0)
ENV FLYWHEEL /flywheel/v0
RUN mkdir -p ${FLYWHEEL}
COPY manifest.json ${FLYWHEEL}

# Copy run script
COPY run ${FLYWHEEL}/run
RUN chmod +x ${FLYWHEEL}/run

# TODO: preserve environment variables

# Configure entrypoint
#ENTRYPOINT ["/flywheel/v0/run"]
