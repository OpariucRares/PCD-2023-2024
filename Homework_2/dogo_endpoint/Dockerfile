FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

COPY ./Dogo.API/Dogo.API.csproj ./Dogo.API/
COPY ./Dogo.Core/Dogo.Core.csproj ./Dogo.Core/
COPY ./Dogo.Infrastructure/Dogo.Infrastructure.csproj ./Dogo.Infrastructure/
COPY ./Dogo.Application/Dogo.Application.csproj ./Dogo.Application/
COPY *.sln ./

RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o build --no-restore 

FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build ./build .
ENV ASPNETCORE_URLS=http://*:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "Dogo.API.dll"]