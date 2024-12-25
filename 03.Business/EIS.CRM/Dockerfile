FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["03.Business/EIS.CRM/EIS.CRM.csproj", "03.Business/EIS.CRM/"]
RUN dotnet restore "03.Business/EIS.CRM/EIS.CRM.csproj"
COPY . .
WORKDIR "/src/03.Business/EIS.CRM"
RUN dotnet build "EIS.CRM.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "EIS.CRM.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "EIS.CRM.dll"]
