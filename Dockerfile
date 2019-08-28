# python-builder
# FROM kubespheredev/s2i-base-centos7
FROM python:3.5.7-slim-buster

# Put the maintainer name in the image metadata
LABEL maintainer="Kubesphere<kubesphere@email.com>"

# Path to be used in other layers to place s2i scripts into
ENV STI_SCRIPTS_PATH=/usr/libexec/s2i \
    APP_ROOT=/opt/app-root \
    # The $HOME is not set by default, but some applications needs this variable
    HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:$PATH

# Set labels used in s2i to describe the builder image
LABEL io.k8s.description="Platform for build" \
      io.k8s.display-name="Python 3.5" \
      io.kubesphere.expose-services="8080:http" \
      io.kubesphere.tags="builder,python-35" \
      name="zhuxiaoyang/python-35-centos7" \
      io.openshift.s2i.scripts-url=image:///usr/libexec/s2i

WORKDIR ${HOME}

# Copy the S2I scripts to /usr/libexec/s2i.
COPY ./s2i/bin/ /usr/libexec/s2i

EXPOSE 8080

# 修改构建器的默认启动命令，以展示构建器镜像的用法
CMD ["/usr/libexec/s2i/usage"]
