FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY Demo.API/Demo.API.csproj Demo.API/
RUN dotnet restore Demo.API/Demo.API.csproj
COPY . .
WORKDIR /src/Demo.API
RUN dotnet build Demo.API.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish Demo.API.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Demo.API.dll"]
