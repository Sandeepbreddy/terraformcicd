FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-local
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
EXPOSE 80
COPY --from=build-local /app/out .
ENTRYPOINT ["dotnet", "samplecicdapi.dll"]