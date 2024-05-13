# Use the official Microsoft .NET runtime as a parent image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Use SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
ARG COMMIT=9dd6d1e2d210e6c76fa0af7991b3eb60008028b4
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