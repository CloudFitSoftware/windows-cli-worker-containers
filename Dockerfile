#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

FROM mcr.microsoft.com/dotnet/core/runtime:3.0-nanoserver-1903 AS base
WORKDIR /app
VOLUME C:\\output

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-nanoserver-1903 AS build
WORKDIR /src
COPY ["src/SampleCli/SampleCli.csproj", "src/SampleCli/"]
RUN dotnet restore "src/SampleCli/SampleCli.csproj"
COPY . .
WORKDIR "/src/src/SampleCli"
RUN dotnet build "SampleCli.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SampleCli.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SampleCli.dll"]
