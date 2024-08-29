# Use the official Microsoft .NET runtime as a parent image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080

# Use SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
ARG COMMIT=fd7886970fa47c10e991bde0399f53924f75a991
RUN git clone https://github.com/coinecta/coinecta-offchain.git
WORKDIR /app/coinecta-offchain/src/Coinecta.API
RUN git checkout ${COMMIT}
RUN dotnet restore
RUN dotnet build -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish -c Release -o /app/publish

# Final stage/image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
COPY ./coinecta.api.settings.json appsettings.json
ENTRYPOINT ["dotnet", "Coinecta.API.dll"]