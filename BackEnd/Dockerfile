FROM microsoft/aspnetcore-build:2.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "BackEnd.dll"]

# Build ethereum blockchain

# DO NOT RUN THE ETHEREUM CLIENT

# FROM ethereum/client-go:stable
# FROM ethereum/client-go:alltools-stable
# EXPOSE 8545
# RUN go-ETHEREUM

# Initial NPM installations and pathsetting

# RUN ./npmInstaller.sh
