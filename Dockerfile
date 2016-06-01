FROM ubuntu:14.04

ARG DEBIAN_FRONTEND=noninteractive

USER root

ADD http://ftp.gramene.org/archives/PAST_RELEASES/release44/data/fasta/triticum_aestivum/dna/Triticum_aestivum.IWGSC2.25.dna.genome.fa.gz /data/

RUN     apt-get -y update && apt-get -yy install apt-utils make g++ libreadline6 libreadline6-dev libssl-dev libreadline-dev curl git-core python-software-properties build-essential zlib1g-dev libyaml-dev libgdbm-dev libncurses5-dev libpq-dev libffi-dev xorg openbox openssl zlib1g-dev autoconf  automake libtool bison sqlite patch bzip2 bison gcc wget ruby-full ruby-dev libgmpxx4ldbl gawk-doc libgmp10-doc libmpfr-dev sqlite3-doc gawk libsqlite3-dev pkg-config mafft exonerate primer3 && \
        gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
        \curl -sSL https://get.rvm.io | bash -s stable && \
        echo source /etc/profile.d/rvm.sh >> /.bashrc && \
        /bin/bash -c "source /.bashrc; rvm install 2.2; rvm use 2.2 --default;gem install bio-polyploid-tools" && \
        gunzip /data/Triticum_aestivum.IWGSC2.25.dna.genome.fa.gz
      
WORKDIR /data/

