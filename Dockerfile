# Based on MashMB/nvim-ide

# Debian image as base (unstable for newest software).
FROM manjarolinux/base:latest

# Set image locale.
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV TZ=Europe/Prague

# Expose some ports to host by default.
EXPOSE 3000 3333 5000 8080 8081 8082 8083 8084 8085

# Lazygit variables
# ARG LG='lazygit'
# ARG LG_GITHUB='https://github.com/jesseduffield/lazygit/releases/download/v0.31.4/lazygit_0.31.4_Linux_x86_64.tar.gz'
# ARG LG_ARCHIVE='lazygit.tar.gz'
#
# # GIT Flow variables
# ARG GIT_FLOW_GITHUB='https://github.com/petervanderdoes/gitflow-avh.git'
# ARG GIT_FLOW_DIR='gitflow-avh'

# Update repositories and install software:
# 1. curl.
# 2. fzf for fast file search.
# 3. ripgrep for fast text occurrence search.
# 4. tree for files tree visualization.
# 5. Git.
# 6. Lazygit for Git visualization.
# 7. xclip for clipboard handling.
# 8. Python 3.
# 9. pip for Python.
# 10. NodeJS.
# 11. npm for NodeJS.
# 12. tzdata to set default container timezone.
# 13. Everything needed to install Neovim from source.
RUN pacman -Syu --noconfirm tree git xclip ninja libtool make autoconf automake \
  cmake pkg-config zip unzip clang

# Install Neovim from source.
RUN mkdir -p /tmp
WORKDIR /tmp
RUN git clone https://github.com/neovim/neovim --depth=1
WORKDIR /tmp/neovim
RUN make CMAKE_BUILD_TYPE=Release && make install
RUN rm -rf /tmp/neovim

RUN pacman -Syu --noconfirm fzf ripgrep nodejs npm github-cli
RUN pacman -Syu --noconfirm cargo bash dotnet-sdk
RUN pacman -Scc --noconfirm

COPY . /root/.config/nvim

# Install Neovim extensions.
RUN nvim --headless "+Lazy! update" "+MasonUpdateAll" +qa

# Create directory for projects (there should be mounted from host).
RUN mkdir -p /root/workspace

# Set default location after container startup.
WORKDIR /root/workspace

# Avoid container exit.
CMD ["tail", "-f", "/dev/null"]
