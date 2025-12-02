#!/bin/bash
# Script para realizar un backup de la base de datos de Odoo

# Cargar variables de entorno desde el archivo .env
# Se asume que el script se ejecuta desde la raíz del proyecto.
if [ -f ./.env ]; then
  export $(cat ./.env | sed 's/#.*//g' | xargs)
else
  echo "Error: Archivo .env no encontrado. Asegúrate de ejecutar el script desde la raíz del proyecto (D:/odoo)."
  exit 1
fi

# --- Verificación del Directorio de Backups ---

# Si BACKUP_DIR no está definido en .env, usar un valor por defecto.
: "${BACKUP_DIR:=./backups}"

echo "Verificando directorio de backups: $BACKUP_DIR"

# 1. Crear el directorio si no existe
if [ ! -d "$BACKUP_DIR" ]; then
  echo "El directorio no existe. Creándolo..."
  mkdir -p "$BACKUP_DIR"
  if [ $? -ne 0 ]; then
    echo "ERROR: No se pudo crear el directorio '$BACKUP_DIR'. Verifica los permisos."
    exit 1
  fi
  echo "Directorio '$BACKUP_DIR' creado."
fi

# 2. Verificar permisos de escritura y asignarlos si es necesario
if [ ! -w "$BACKUP_DIR" ]; then
  echo "El directorio no tiene permisos de escritura. Intentando asignarlos..."
  chmod +w "$BACKUP_DIR"
  if [ ! -w "$BACKUP_DIR" ]; then
    echo "ERROR: No se pudieron asignar los permisos de escritura a '$BACKUP_DIR'."
    echo "Por favor, verifica los permisos de la carpeta manualmente."
    exit 1
  fi
  echo "Permisos de escritura asignados."
fi

# --- Creación del Backup ---

TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_FILE="$BACKUP_DIR/backup-$TIMESTAMP.sql"

echo "Creando backup de la base de datos '$DB_NAME' en el archivo '$BACKUP_FILE'..."

# Comando para realizar el backup
docker exec -t "$CONTAINER_NAME" pg_dump -U "$DB_USER" -d "$DB_NAME" > "$BACKUP_FILE"

# Comprobar si el backup se ha creado correctamente y no está vacío
if [ $? -eq 0 ] && [ -s "$BACKUP_FILE" ]; then
  echo "----------------------------------------------------------------"
  echo "Backup de la base de datos '$DB_NAME' creado con éxito:"
  echo "$BACKUP_FILE"
  echo "----------------------------------------------------------------"
else
  echo "----------------------------------------------------------------"
  echo "ERROR: Ocurrió un problema al crear el backup."
  rm -f "$BACKUP_FILE" # Eliminar archivo de backup fallido o vacío
  echo "----------------------------------------------------------------"
  exit 1
fi
