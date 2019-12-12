param(
    [string]$data="Hello Windows Containers!"
)
$containerName = "wincli_sample"
try {
    docker rm $containerName --force
} catch {}

docker build . -t wincli_worker:latest
docker run --env MY_DATA=$data --name $containerName wincli_worker:latest
$outputDir = (docker inspect $containerName | ConvertFrom-Json)[0].Mounts.Source
explorer $outputDir
