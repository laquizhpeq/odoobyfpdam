# Usamos la imagen oficial de Odoo 17 como base
FROM odoo:17.0

# Cambiamos al usuario root para poder instalar paquetes
USER root

# Actualizamos la lista de paquetes e instalamos el cliente de PostgreSQL.
# Esto nos dará acceso a los comandos pg_dump y pg_restore.
# Luego, limpiamos la caché para mantener la imagen ligera.
RUN apt-get update && \
    apt-get install -y postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Volvemos al usuario por defecto de Odoo para mantener la seguridad
USER odoo
