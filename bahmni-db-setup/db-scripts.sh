#!/bin/sh
mysql --host="${DB_HOST}" --user="${DB_ROOT_USERNAME}" --password="${DB_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS openmrs;";
mysql --host="${DB_HOST}" --user="${DB_ROOT_USERNAME}" --password="${DB_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS nouman;";
mysql --host="${DB_HOST}" --user="${DB_ROOT_USERNAME}" --password="${DB_ROOT_PASSWORD}" -e "SHOW DATABASES;";