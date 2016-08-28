# Docker image ahin017/report-openapitransform:toHtml
# For executing 'toHtml' pipeline

FROM ubuntu:16.04
MAINTAINER Ashley Noel Hinton <ahin017@aucklanduni.ac.nz>

# set locale to UTF-8
RUN sed -i -e 's/# en_NZ.UTF-8 UTF-8/en_NZ.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_NZ.UTF-8"' > /etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_NZ.UTF-8
ENV LANG en_NZ.UTF-8 

# add CRAN PPA
RUN apt-get update && apt-get install -y apt-transport-https
RUN echo 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial/' > /etc/apt/sources.list.d/cran.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# install system packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libxml2-utils \
    python-dev \
    r-base=3.3.1* \
    wget \
    xsltproc \
&& rm -rf /var/lib/apt/lists/*

# install R packages
COPY Rpackages.R /usr/local/src/myscripts/
RUN ["Rscript", "/usr/local/src/myscripts/Rpackages.R"]

RUN wget -O conduit-0.6-3.tar.gz \
    https://github.com/anhinton/conduit/archive/v0.6-3.tar.gz \
&& R CMD INSTALL conduit-0.6-3.tar.gz
