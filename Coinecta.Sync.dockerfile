# Use the official Microsoft .NET runtime as a parent image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Use SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
ARG COMMIT=8d2cf7e5278049ae3223fa13117a34d5b70a1122
RUN git clone https://github.com/coinecta/coinecta-offchain.git
WORKDIR /app/coinecta-offchain/src/Coinecta.Sync
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
ENTRYPOINT ["dotnet", "Coinecta.Sync.dll"]