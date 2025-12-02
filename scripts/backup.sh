#!/bin/bash
# Script para realizar un backup de la base de datos de Odoo

# Cargar variables de entorno desde el archivo .env
if [ -f D:/odoo/.env ]; then
  export $(cat D:/odoo/.env | sed 's/#.*//g' | xargs)
fi

# Variables
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

# Crear directorio de backups si no existe
mkdir -p $BACKUP_DIR

# Comando para realizar el backup
docker exec -t $CONTAINER_NAME pg_dump -U $DB_USER -d $DB_NAME > $BACKUP_DIR/backup-$TIMESTAMP.sql

# Comprobar si el backup se ha creado correctamente
if [ $? -eq 0 ]; then
  echo "Backup de la base de datos '$DB_NAME' creado correctamente en $BACKUP_DIR/backup-$TIMESTAMP.sql"
else
  echo "Error al crear el backup de la base de datos '$DB_NAME'"
fi
