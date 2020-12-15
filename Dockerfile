FROM claudiugeorgiu/obfuscapk:latest

ENV BUILD_TOOLS_VERSION="29.0.3"

# Install cmkae
RUN apt update
RUN apt install --no-install-recommends -y cmake make openjdk-11-jdk-headless


# 1 JAR in Sdk/platoforms/
# 2 ndk-bundle/toolchains
# 3 build-tools
RUN sdkmanager --sdk_root="${ANDROID_HOME}" "platforms;android-26" && \
    sdkmanager --sdk_root="${ANDROID_HOME}" "ndk-bundle" && \
    sdkmanager --sdk_root="${ANDROID_HOME}" "build-tools;${BUILD_TOOLS_VERSION}"

# Clean
RUN apt autoremove --purge -y && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ALIAS: /Android/Sdk -> /android-sdk-linux
RUN mkdir /root/Android && \
    mkdir /Android && \
    ln -s ${ANDROID_HOME} /root/Android/Sdk && \
    ln -s ${ANDROID_HOME} /Android/Sdk


# Copy the jar from this folder
COPY antirepackaging-framework-all-1.0-SNAPSHOT.jar /bin/antirepackaging.jar

# Entrypoint a script that runs jar and then python
COPY entrypoint.sh /bin
RUN chmod +x /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]
