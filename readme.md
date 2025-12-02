# Proyecto Odoo con Docker

Esta guía describe los pasos para configurar y administrar el entorno de Odoo utilizando Docker.

## Pasos de Instalación y Administración

### Paso 1: Detener y Eliminar Contenedores y Volúmenes

Para realizar una limpieza completa del entorno anterior, ejecuta el siguiente comando. Esto detendrá los contenedores y eliminará los volúmenes de datos asociados.

```bash
docker-compose down -v
```

### Paso 2: Levantar los Servicios de Odoo

Una vez limpio el entorno, levanta todos los servicios (Odoo y PostgreSQL) en segundo plano.

```bash
docker-compose up -d
```

### Paso 3: Creación de la Base de Datos

Después de levantar los contenedores, debes crear la base de datos desde la interfaz web de Odoo.

1.  Abre tu navegador y ve a [http://localhost:8069](http://localhost:8069).
2.  Verás la pantalla de creación de base de datos de Odoo. Rellena el formulario:
    *   **Master Password**: `mostrara en la pantalla`
    *   **Database Name**: `odoo` o el nombre que prefieras.
    *   **Email**: `admin` (o tu email).
    *   **Password**: Elige una contraseña para el usuario administrador de Odoo.
    *   **Language y Country**: Elige tus preferencias.
    *   **Load demonstration data**: Marca esta casilla si quieres datos de ejemplo.
3.  Haz clic en **"Create database"**.

El proceso tardará unos minutos. Al finalizar, serás redirigido a la pantalla de inicio de sesión de Odoo.

## Scripts Adicionales

### Backup de la Base de Datos

Para realizar un respaldo de la base de datos, ejecuta el siguiente script desde la raíz del proyecto.

```bash
./scripts/backup.sh
```

> **Nota para usuarios de Windows:**
> Este es un script de shell (`.sh`) y debe ejecutarse en una terminal que pueda interpretar bash, como **Git Bash**. No funcionará en el Símbolo del sistema (`cmd.exe`) o PowerShell de forma nativa.
