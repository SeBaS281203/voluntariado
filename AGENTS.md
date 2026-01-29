# Repository Guidelines

## Project Structure & Module Organization
This is a Java 21 Maven web app (JSP/Servlets) with a layered package layout.
- `src/main/java/Entidades`: domain models (e.g., `Usuario`, `Actividad`).
- `src/main/java/Datos`: data access and DB connection logic (e.g., `Conexion`, DAOs).
- `src/main/java/Negocio`: service layer that coordinates business rules.
- `src/main/java/com/miapp/controllers`: servlet controllers (login, menu, voluntarios, actividades).
- `src/main/webapp/views`: JSP pages for the UI.
- `src/main/webapp/index.jsp`: entry redirect to `/login`.
- `Voluntariado.mwb`: MySQL Workbench schema/model file.
- `target/`: build outputs (generated).

## Build, Test, and Development Commands
Run from the repo root using the Maven wrapper:
- `./mvnw clean package`: build the WAR for deployment.
- `./mvnw -q -DskipTests package`: faster build when you do not need tests.
- Deploy the WAR from `target/` to Tomcat 10+ (`$TOMCAT_HOME/webapps`) and open `/login`.

## Coding Style & Naming Conventions
- Java with 4-space indentation; keep package names lowercase and class names `PascalCase`.
- Servlet classes use `*Servlet`; services use `*Service`, DAOs use `*DAO`.
- JSPs live under `src/main/webapp/views` and are routed by servlets.
- No formatter/linter is configured; keep changes consistent with existing style.

## Testing Guidelines
There are currently no automated tests or testing framework configured.
- If adding tests, use standard Maven layout under `src/test/java` and name classes `*Test`.
- Document how to run new tests in this file and add them to CI if introduced.

## Commit & Pull Request Guidelines
Git history shows a single commit (`Add files via upload`), so no convention is established.
- Use short, imperative commit subjects (e.g., “Add volunteer search”).
- PRs should include a clear summary, steps to verify, and screenshots for UI changes.

## Security & Configuration Tips
- Database connection settings live in `src/main/java/Datos/Conexion.java`.
- Avoid committing real credentials; use local overrides or environment-specific values.
- `Usuario y Contraseña.txt` appears to contain credentials—treat as local-only data.
