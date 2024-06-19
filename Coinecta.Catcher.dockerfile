# Use the official Microsoft .NET runtime as a parent image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Use SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
ARG COMMIT=c69dea61873ddde46ee0e0f9d8eeca0d38b89d42
RUN git clone https://github.com/coinecta/coinecta-offchain.git
WORKDIR /app/coinecta-offchain/src/Coinecta.Catcher
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
ENTRYPOINT ["dotnet", "Coinecta.Catcher.dll"]