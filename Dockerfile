FROM archlinux
RUN pacman -Syu --needed --noconfirm git base-devel

ARG user=makepkg
RUN useradd --system --create-home $user \
  && echo "$user ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/$user
USER $user
WORKDIR /home/$user

RUN git clone https://aur.archlinux.org/mkg3a.git \
  && cd mkg3a \
  && makepkg -sri --needed --noconfirm \
  && cd \
  && rm -rf .cache mkg3a

RUN git clone https://aur.archlinux.org/sh3eb-elf-binutils.git \
  && cd sh3eb-elf-binutils \
  && makepkg -sri --needed --noconfirm \
  && cd \
  && rm -rf .cache sh3eb-elf-binutils

RUN git clone https://aur.archlinux.org/sh3eb-elf-gcc.git \
  && cd sh3eb-elf-gcc \
  && makepkg -sri --needed --noconfirm \
  && cd \
  && rm -rf .cache sh3eb-elf-gcc
