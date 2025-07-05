# Imagen base de Maven con Alpine Linux
FROM docker.io/library/maven:3.8.5-openjdk-17 AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copiar proyecto
COPY . .

# Comando para compilar la aplicación
RUN mvn clean install -DskipTests

# Imagen base de OpenJDK con Alpine Linux
FROM docker.io/library/openjdk:17-jdk-alpine

# Copiar el archivo JAR de la aplicación
COPY --from=build /app/presentacion/target/presentacion-0.0.1-SNAPSHOT.jar app.jar

# Exponer el puerto de la API 
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "app.jar"]
