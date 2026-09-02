# =========================================================
# Etapa 1 - build do .jar com Maven
# =========================================================
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app

# Baixa as dependencias primeiro, para aproveitar o cache de camadas
COPY pom.xml .
RUN mvn -B -q dependency:go-offline

COPY src ./src
RUN mvn -B -q clean package -DskipTests

# =========================================================
# Etapa 2 - imagem final, apenas o runtime
# =========================================================
FROM eclipse-temurin:21-jre
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

# Credenciais e perfil chegam por variavel de ambiente (nunca no codigo)
ENV DB_URL="jdbc:oracle:thin:@oracle.fiap.com.br:1521:ORCL" \
    DB_USER="" \
    DB_PASSWORD="" \
    SPRING_PROFILES_ACTIVE="" \
    PORT=8080

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
