**ARMAND (Anti-Repackaging through Multi-patternAnti-tampering based on Native Detection)** is a novel anti-tampering protection scheme that embeds logic bombs and AT 
detection nodes directly in the apk file without needing their source code. We developed ARMANDroid, an ARMAND implementation for Android apps.
ARMANDroid uses [soot](https://github.com/soot-oss/soot) to decompile the original apk file and to build a new application, applying anti tampering techniques and build a new application.

It is recommended to use ARMANDroid in combination with an obfuscation tool. In our dockerfile
we will use [Obfuscapk](https://github.com/ClaudiuGeorgiu/Obfuscapk).

## ❱ Publication

More details about **ARMAND** can be found in the paper
"[]()".
You can cite the paper as follows:

```BibTeX
[...]
```

## ❱ Usage

### Docker image

----------------------------------------------------------------------------------------

#### Prerequisites

The only requirement is to have a recent version of Docker installed:

```Shell
$ docker --version
Docker version 19.03.0, build aeac949
```

#### Official Docker Hub image

The [official ARMAND Docker image](https://hub.docker.com/repository/docker/totor13/armand)
is available on Docker Hub (automatically built from this repository):

```Shell
$ # Download the Docker image.
$ docker pull totor13/armand
$ # Give it a shorter name.
$ docker tag totor13/armand armand
```

#### Usage
A local directory containing the application to protect has to be
mounted to `/workdir` in the container (e.g., the current directory `"${PWD}"`) with the
command:
```Shell
$ docker run --rm -it -u $(id -u):$(id -g) -v "${PWD}":"/workdir" armand [params...]
```

Simple usage, ARMAND only:
```Shell
$ docker run --rm -it -u $(id -u):$(id -g) -v "${PWD}":"/workdir" armand -i ${APK_IN} -k "${KEYSTORE_PATH}:${KEYSTORE_PASSWORD}:PKCS12:${KEYSTORE_ALIAS}"
```
The protected app will be available under `${PWD}/sootOutput`.

More information are available in the help message:

```Shell
$ docker run armand --help
usage: ARMAND
 -a,--android-jars <arg>                    The path to the android jars.
                                            The default is
                                            '$HOME/Android/Sdk/platforms'
 -c,--soot-classpath <arg>                  The path to the wanted
                                            soot.jar file.
 -i,--apk-path <arg>                        The path to the target apk
                                            file.
 -ja,--java-at-percentage <arg>             The percentage of Java AT
 -k,--key-store <arg>                       Information of the keystore
                                            used to sign the output apk:
                                            <path:type:password:alias>
 -na,--native-at-percentage <arg>           The percentage of native AT
 -ne,--native-encryption-percentage <arg>   The percentage of native
                                            encryption
 -o,--output-format <arg>                   The output format (dex,
                                            class). The default is dex
 -p,--package-name <arg>                    The package name where to
                                            insert bombs. "none" to
                                            include all classes (libraries
                                            included). Default value is
                                            taken from Manifest file

```


#### Usage with Obfuscapk
Obfuscapk parameters must be added after `--obfuscapk`. This parameter must be inserted after ARMAND params.
Example:
```Shell
$ docker run --rm -it -u $(id -u):$(id -g)  -v "${PWD}":"/workdir" armand -i ${APK_IN} -k "${KEYSTORE_PATH}:${KEYSTORE_PASSWORD}:PKCS12:${KEYSTORE_ALIAS}  --obfuscapk -o RandomManifest -o Rebuild -o NewSignature -o NewAlignment sootOutput/${APK_IN}"
```

The protected app will be available under `${PWD}/sootOutput/obfuscation_working_dir`.




## ❱ Credits

[![Unige](https://intranet.dibris.unige.it/img/logo_unige.gif)](https://unige.it/en/)
[![Dibris](https://intranet.dibris.unige.it/img/logo_dibris.gif)](https://www.dibris.unige.it/en/)

This software was developed for research purposes at the Computer Security Lab
([CSecLab](https://csec.it/)), hosted at DIBRIS, University of Genoa.



## ❱ Team

* [Alessio Merlo](https://csec.it/people/alessio_merlo/) - Faculty Member
* [Luigi Sciolla](https://github.com/Killuaa27/) - Developer
* [Antonio Ruggia](https://github.com/totoR13) - Core Developer
* [Luca Verderame](https://csec.it/people/luca_verderame/) - Postdoctoral Researcher
