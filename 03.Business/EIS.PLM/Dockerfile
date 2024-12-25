FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["03.Business/EIS.PLM/EIS.PLM.csproj", "03.Business/EIS.PLM/"]
RUN dotnet restore "03.Business/EIS.PLM/EIS.PLM.csproj"
COPY . .
WORKDIR "/src/03.Business/EIS.PLM"
RUN dotnet build "EIS.PLM.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "EIS.PLM.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "EIS.PLM.dll"]
