# Storing Results From Ephemeral Windows Worker Containers

This sample demonstrates the use of volume mounts in a Docker container to run a CLI-based Windows application as a worker app in a containerized environment. 

This practice is useful in scenarios where you have an existing Windows CLI application that you'd like to containerize and run in a horizontally scalable, batch-like environment.

## Volume Mounts
In Windows containers, volume mounts are expressed within the Dockerfile in the format of
```
VOLUME C:\\output
```

By default, Docker creates a folder for each Windows container instance in a `C:\ProgramData\Docker\volumes\<container-id>\_data` directory, but this can be overridden during the Docker run command. In the following example, we'll mount the container's `C:\output` directory to a location on the `E:` of the host.

```
docker run -v E:\my_data_host\container_data:C:\output
```

## Cloud Storage
An alternative to storing data via locally mounted volumes is to transmit the data to some persistent cloud storage, such as Azure Blob, S3 buckets, etc. In cases where this storage mechanism is desired, but the original Windows application cannot be easily modified, it may be possible to craft a small "shim" application that can accept configuration, run the target application, and then collect and transmit its output to the desired cloud storage.

# Example application

Assuming Docker is installed, and configured to use Windows containers, you can run this sample by running the `./run_sample.ps1` script from the repository's root directory.

This script should invoke a multi-stage Docker build of the .NET Core console application, run the image, and then launch a Windows Explorer window opened to the container's data directory on the host, so that you can view the persisted output from the container.

# References

See the following source for more information on creative usage of volume mounts in Windows containers:

https://blog.sixeyed.com/docker-volumes-on-windows-the-case-of-the-g-drive/